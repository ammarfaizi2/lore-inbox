Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTEMWSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbTEMWS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:18:27 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:26416 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263632AbTEMWQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:16:17 -0400
Date: Tue, 13 May 2003 17:28:58 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
cc: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: 2.5.69-mm4 fails to boot
Message-ID: <203980000.1052864937@baldur.austin.ibm.com>
In-Reply-To: <20030513221435.GI32128@ca-server1.us.oracle.com>
References: <20030513221435.GI32128@ca-server1.us.oracle.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 13, 2003 15:14:36 -0700 Joel Becker
<Joel.Becker@oracle.com> wrote:

> 	2.5.69-mm4 is failing to boot.  It completes init_rootfs() in
> mnt_init() but does not complete init_mount_tree().  Call me dumb, but
> nothing obvious jumps out at me, I don't see any diff(1) from -mm3, and
> I don't really have time to actively debug it.  I can indeed build and
> try kernels.
> 	This is the WimMark box.  Compaq ML570.  4x700MHz Xeon, 2GB RAM.
> Still boots all the other kernels fine.

I have the same exact problem.  It hange in exactly the same place.  My
machine is a dual Pentium Pro w/ 128M RAM, and not much else.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

