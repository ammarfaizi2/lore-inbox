Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTBBNKQ>; Sun, 2 Feb 2003 08:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbTBBNKQ>; Sun, 2 Feb 2003 08:10:16 -0500
Received: from smtp04.iprimus.com.au ([210.50.76.52]:5139 "EHLO
	smtp04.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S265246AbTBBNKP>; Sun, 2 Feb 2003 08:10:15 -0500
Message-Id: <5.1.0.14.0.20030203000618.00a0eb20@pop.iprimus.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 03 Feb 2003 00:19:08 +1100
To: linux-kernel@vger.kernel.org
From: James Buchanan <jamesbuch@iprimus.com.au>
Subject: Anyone supporting Intel 8XX chipset???
Cc: alan@lxorguk.ukuu.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-OriginalArrivalTime: 02 Feb 2003 13:19:41.0172 (UTC) FILETIME=[BE651340:01C2CABD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone writing code to directly support features of the Intel 800 series
chipsets?  I'm using the 8xx chipset docs from Intel to gradually
implement (hopefully) all the features of the 800 series of chipsets.

The support of the I/O hubs and so on to get rid of relying on legacy
PC/AT stuff will take a while.

I have a couple of questions because I'm new to kernel contributions.
I'll be working in two main files, i8xx.h and i8xx.c, possibly i8xx.s too.
In the early stages I may have a directory /i8xx and implementation of
specific features will go into there in separate files.

Now, I need to add an option like -DHAVE_INTEL800_CHIPSET to the kernel
configuration so my code can see if we should compile in this stuff.

Where does it go?  I will only make patches for the kernel files that deal with
that, and I will be patching against 2.4.20.  All my chipset stuff will 
otherwise
be in separate files.

One thing: should I maintain the consistency of using /dev files?  Because 
there
is a hardware random number generator in the 800 series chipsets, and I
am wondering whether I should export this feature as a set of functions or
a /dev file.  (Both??)

Thanks!
James Buchanan

