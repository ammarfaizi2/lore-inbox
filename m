Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263522AbREYE24>; Fri, 25 May 2001 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263523AbREYE2q>; Fri, 25 May 2001 00:28:46 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:2797 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263522AbREYE2g>; Fri, 25 May 2001 00:28:36 -0400
Date: Fri, 25 May 2001 00:29:05 -0400 (EDT)
From: Scott Murray <scott@spiteful.org>
X-X-Sender: <scottm@godzilla.spiteful.org>
To: Greg Johnson <gjohnson@research.canon.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Big-ish SCSI disks
In-Reply-To: <20010525000502.B998037530@zapff.research.canon.com.au>
Message-ID: <Pine.LNX.4.33.0105250015550.15333-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Greg Johnson wrote:

> Hi kernel poeple,
>
> Can anyone out there say for certain that 76GB SCSI disks should
> just work with kernel versions 2.2 and/or 2.4? We need to get some
> big disk space and have heard reports of problems with disks
> bigger than 30GB under linux.

I set up a machine at work a few months ago with two Seagate 73GB
Ultra160 drives (model ST173404LW) using the Adaptec AIC-7899 adapter
on board a ServerWorks LE chipset based motherboard.  Everything has
been working fine using the stock RedHat 7.0 2.2.16-22smp kernel.  I
also played with some 2.4.1-ac kernels to try out ReiserFS, and also
had no problems using the disks.

Scott


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.spiteful.org (coming soon)                 ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"

