Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWG0R3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWG0R3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWG0R3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:29:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751893AbWG0R3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:29:51 -0400
Date: Thu, 27 Jul 2006 13:29:44 -0400
From: Dave Jones <davej@redhat.com>
To: Tom Horsley <tom.horsley@ccur.com>
Cc: 7eggert@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] documentation: Documentation/initrd.txt
Message-ID: <20060727172944.GJ5687@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tom Horsley <tom.horsley@ccur.com>, 7eggert@gmx.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <6DfYt-7zU-49@gated-at.bofh.it> <E1G69M4-0001Um-Jg@be1.lrz> <1154020546.5166.35.camel@tweety>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154020546.5166.35.camel@tweety>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:15:46PM -0400, Tom Horsley wrote:
 > On Thu, 2006-07-27 at 19:08 +0200, Bodo Eggert wrote:
 > > > I spent a long time the other day trying to examine an initrd
 > > > image on a fedora core 5 system because the initrd.txt file
 > > > is apparently obsolete. Here is a patch which I hope
 > > > will reduce future confusion for others.
 > > 
 > > Your documentation is technically wrong, and there is a better
 > > explanation:
 > 
 > I find it easy to believe my document is wrong, but looking at
 > the Documentation/filesystems/ramfs-rootfs-initramfs.txt file
 > would never have led me to believe that the initrd.img file
 > was related in any way. The ramfs-rootfs-initramfs.txt
 > file describes the the archive as being built into the
 > kernel, so it needs updating too I guess (and fedora
 > should change the name of the initrd files to be
 > initramfs files so I'll look for documentation in the right
 > place :-).

It's largely kept all the old names for historical reasons.
We *could* rename stuff, but then we'd also have to rename
the mkinitrd package, the scripts that call it, etc etc
for no real gain.

		Dave

-- 
http://www.codemonkey.org.uk
