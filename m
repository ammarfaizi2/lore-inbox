Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUBFFCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 00:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUBFFCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 00:02:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266192AbUBFFCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 00:02:03 -0500
Date: Fri, 6 Feb 2004 00:02:01 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.2-mm1, selinux, and initrd
In-Reply-To: <200402060228.i162SwKo004935@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0402060001090.13144-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> Booting 2.6.2-mm1, I get:
> 
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> Mounted devfs on /dev
> VFS: Cannot open root device 
> 
> and things come to a screeching halt.  Absolutely nothing in the linuxrc
> seems to happen - and since the real root is on an LVM, we come to a
> screeching halt.
> 

Are you able to try this without devfs?


- James
-- 
James Morris
<jmorris@redhat.com>


