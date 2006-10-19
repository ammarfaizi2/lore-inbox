Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946312AbWJSSXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946312AbWJSSXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946305AbWJSSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:23:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:24513 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423153AbWJSSXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:23:11 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Linux
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dealing with excessive includes
Date: Thu, 19 Oct 2006 20:24:03 +0200
User-Agent: KMail/1.9.5
Cc: Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061017005025.GF29920@ftp.linux.org.uk> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610192024.03511.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 18:32, Linus Torvalds wrote:
> I think ext2 was already fixed to use its own spinlocks for bitmap
> accesses, although it looks like somebody re-introduced "lock_super()"
> there for xattr handling.

I'll send a cleanup patch for that.

Thanks,
Andreas
