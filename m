Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbULPQ7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbULPQ7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbULPQ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:59:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:5862 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261867AbULPQ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:58:34 -0500
Subject: Re: More detail: Re: visor.ko freezes on dlpsh list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bchimiak@earthlink.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, greg@kroah.com
In-Reply-To: <13677005.1103215413764.JavaMail.root@louie.psp.pas.earthlink.net>
References: <13677005.1103215413764.JavaMail.root@louie.psp.pas.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103212485.21823.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 15:54:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 16:43, bchimiak@earthlink.net wrote:
> It is the visor.[ch] of vmlinuz-2.6.9-1.681_FC3 that does not work.
> I recompiled a linux-2.6.9 kernel and the pilot-xfer, dlpsh, and kpilot work
> now.  It is the visor.[ch] in vmlinuz-2.6.9-1.681_FC3 that is the culprit.

That would make sense. Vanilla 2.6.9 has the visor denial of service
hole (and a mass of other holes but none of the others touch visor). The
earlier fix had a bug in it and is in 681_FC3, the full fix is in the
later kernels and in current 2.6.9-ac and should work fine.

