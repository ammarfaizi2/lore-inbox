Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTENSjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTENSjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:39:09 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:21118 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263529AbTENSiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:38:50 -0400
Date: Wed, 14 May 2003 13:36:10 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
cc: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: 2.5.69-mm4 fails to boot
Message-ID: <115460000.1052937370@baldur.austin.ibm.com>
In-Reply-To: <203980000.1052864937@baldur.austin.ibm.com>
References: <20030513221435.GI32128@ca-server1.us.oracle.com>
 <203980000.1052864937@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, May 13, 2003 17:28:58 -0500 Dave McCracken wrote:
> --On Tuesday, May 13, 2003 15:14:36 -0700 Joel Beckerwrote:
>> 	2.5.69-mm4 is failing to boot.  It completes init_rootfs() in
>> mnt_init() but does not complete init_mount_tree().  Call me dumb, but
>> nothing obvious jumps out at me, I don't see any diff(1) from -mm3, and
>> I don't really have time to actively debug it.  I can indeed build and
>> try kernels.
>> 	This is the WimMark box.  Compaq ML570.  4x700MHz Xeon, 2GB RAM.
>> Still boots all the other kernels fine.
> 
> I have the same exact problem.  It hange in exactly the same place.  My
> machine is a dual Pentium Pro w/ 128M RAM, and not much else.

I didn't get a chance to chase this, but 2.5.69-mm5 boots just fine, so
whatever caused it has been fixed for me.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

