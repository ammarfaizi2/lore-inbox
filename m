Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFUMpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFUMpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFUMoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:44:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6564 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261315AbVFUMmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:42:23 -0400
Subject: Re: -mm -> 2.6.13 merge status (fuse)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119357566.3325.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 13:39:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 11:22, Miklos Szeredi wrote:
> So I welcome constructive discussion.  However bear in mind, that I
> definitely don't want to disable unprivileged mounts.  For me that is
> _the_ most important feature of FUSE.

If the choice was "merge FUSE without unpriv mounts for now" or "discard
fuse completely" which is preferable.

It seems to me (just IMHO) that it would be better to merge FUSE without
that feature and then spend the time getting that feature right _in
parallel_ with people using, breaking and reviewing FUSE a lot more.

