Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310429AbSCPQfD>; Sat, 16 Mar 2002 11:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310430AbSCPQex>; Sat, 16 Mar 2002 11:34:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32398 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310429AbSCPQeo>;
	Sat, 16 Mar 2002 11:34:44 -0500
Date: Sat, 16 Mar 2002 11:34:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7-pre2 link error in kernel.o with nfs but !nfsd configured
In-Reply-To: <Pine.SOL.3.96.1020316162023.5310D-100000@libra.cus.cam.ac.uk>
Message-ID: <Pine.GSO.4.21.0203161132160.5891-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Anton Altaparmakov wrote:

> 2.5.7-pre2 (am using bitkeeper version from linux.bkbits.net/linux-2.5)
> fails to link at the final stage of make bzImage.
> 
> The error is that sys_nfsservctl is referenced from kernel.o but it can't 
> find it.

See patches posted on l-k.  The latest variant (fix for nfsservctl() +
cleanup for quotactl() + cleanup for acct()) is in usual place, name
0-aliases-c-C7-pre2.

