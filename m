Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264666AbUDVUlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbUDVUlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUDVUlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:41:14 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:35570 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264666AbUDVUlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:41:11 -0400
Date: Thu, 22 Apr 2004 21:41:10 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: fabian.frederick@prov-liege.be
cc: linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] 2.6.4v SFS instead of NTFS mp
In-Reply-To: <S263475AbUDVJJd/20040422090933Z+101@vger.kernel.org>
Message-ID: <Pine.SOL.4.58.0404222139100.15577@orange.csi.cam.ac.uk>
References: <S263475AbUDVJJd/20040422090933Z+101@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004 fabian.frederick@prov-liege.be wrote:
>      Using vanilla 2.6.4 with ntfs module, when fdisk /dev/hdb which is
> some 80Gb multi-partionned ntfs, it appears as mono-block SFS ...
> Strange behaviour !?
>
> PS : Please reply ; not subscribed to lkml.

Normal behaviour.  The disk in question is a dynamic disk as created by
Windows 2k/xp or later.  You need to compile in windows dynamic disk (LDM)
support into your kernel and then your disk's partitions will be
recognised properly.  Note AFAIK there are no tools in existence for Linux
that will allow you to modify the dynamic disk partition layout.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
