Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbSA1KIL>; Mon, 28 Jan 2002 05:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSA1KIA>; Mon, 28 Jan 2002 05:08:00 -0500
Received: from clyde.its.caltech.edu ([131.215.48.174]:53969 "EHLO
	clyde.its.caltech.edu") by vger.kernel.org with ESMTP
	id <S282843AbSA1KHv>; Mon, 28 Jan 2002 05:07:51 -0500
Date: Mon, 28 Jan 2002 02:07:50 -0800 (PST)
From: Steven Hassani <hassani@its.caltech.edu>
X-X-Sender: hassani@clyde
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon Optimization Problem
In-Reply-To: <Pine.GSO.4.42.0201252339350.8662-100000@blinky>
Message-ID: <Pine.GSO.4.42.0201280204540.11467-100000@clyde>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jan 2002, Steven Hassani wrote:

> 	I'm running a compaq presario 700us: duron 950 mhz on a via mobo
> (vt8363/8365 etc).  When running kernel 2.4.17 with athlon optimizations,
> the box has kernel panics, segmentation faults, and other errors.
> When setting to K6 though, the box appears to be stable.  So does the fix
> included in pci-pc.c not work with my system?  Has anyone else been
> getting these errors after using this fix?  Thanks.
> Steve
>
>
	Yea, I just found out that this problem is fixed in the latest
pre...all the bits in register 55 are set to 0, rather than just the high
bit.

Steve


