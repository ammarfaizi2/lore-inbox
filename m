Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSLUVEe>; Sat, 21 Dec 2002 16:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbSLUVEe>; Sat, 21 Dec 2002 16:04:34 -0500
Received: from [81.2.122.30] ([81.2.122.30]:26629 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264954AbSLUVEc>;
	Sat, 21 Dec 2002 16:04:32 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212212123.gBLLNEGI001935@darkstar.example.net>
Subject: Re: First Bug Found : RE: How to help new comers trying the v2.5x series kernels.
To: sampson@attglobal.net (Sampson Fung)
Date: Sat, 21 Dec 2002 21:23:14 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mec@shout.net
In-Reply-To: <000c01c2a930$754a6790$0100a8c0@noelpc> from "Sampson Fung" at Dec 22, 2002 04:35:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is my first problem:  (This problem exist since v2.5.49, and up to
> v2.5.52)
> In will be talk about the following 4 lines below:
> 
> =============================
> 
> General setup  --->
> Loadable module support  --->
> Processor type and features  --->
> ============================     
> 1.	I ssh into my box, terminal is ANSI, rows=25, columns=80
> a.	Just after "make menuconfig", what I get is:
> 
> The letter 'P' is actuall at Column 5
> =============================
> 
> General setup  --->
> Loadable module support  --->
> Processor type and features  --->
> ============================     
> 
> b.	Press <down arrow> once, what I get is:
> 
> The letter 'P' is actuall at Column 5
> The letter 'C' and second 'G' is actuall at Column 15
> =============================
>                 Code maturity level options  --->
> General seGeneral setup  --->
> Loadable module support  --->
> Processor type and features  --->
> ============================     
> 
> c.	If I kept pressing <down arrow>, the first letter of the current
> title will be overlay to the column 15 of the current, for each line.
> 
> 2.	If I "make menuconfig" in Console, where terminal is "linux",
> the "horizontal displacement" still occur but only at 2 columns to the
> right hand side only.
> 
> 3.	The same problem for v2.4.20
> 
> Is this a know bug?

I don't think so, but I did notice that make menuconfig wasn't working
properly on a serial console with the recent 2.5 trees.

> Where should I search before posting here?

The MAINTAINERS file tells you who to contact, (as well as this list):

CONFIGURE, MENUCONFIG, XCONFIG
P:      Michael Elizabeth Chastain

John.
