Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbRBVAw3>; Wed, 21 Feb 2001 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130437AbRBVAwJ>; Wed, 21 Feb 2001 19:52:09 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:54773 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129170AbRBVAwB>; Wed, 21 Feb 2001 19:52:01 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102220051.f1M0pLw18748@webber.adilger.net>
Subject: Re: PROBLEM: ext2 superblock issue on 2.4.1-ac20
In-Reply-To: <20010221163514.A671@turbolinux.com> from Prasanna P Subash at "Feb
 21, 2001 04:35:14 pm"
To: Prasanna P Subash <psubash@turbolinux.com>
Date: Wed, 21 Feb 2001 17:51:20 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> I just oldconfiged linux kernel with my 2.4.1 .config. When I boot the new
> 2.4.1-ac20 kernel, I get a message saying that my ext2 superblock is
> corrupted.

The exact message would be helpful.

> I get a message asking me to run e2fsck -b 8193 <...hdd dev..>

This is an e2fsck message, indicating you may have a corrupt superblock,
or the superblock has unsupported features.  Which version of e2fsck do
you have?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
