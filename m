Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVBUOUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVBUOUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVBUOUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:20:23 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:20416 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261983AbVBUOUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:20:19 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Martin =?ISO-8859-1?Q?=20MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: memory management weirdness
Date: Mon, 21 Feb 2005 14:20:17 +0000
Message-Id: <022120051420.20884.4219EE21000C6C9400005194220588448400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>   I have received no answer to my former question
> (see http://marc.theaimsgroup.com/?l=linux-kernel&m=110827143716215&w=2).
> I've spent some more time on that problem and have more or less confirmed
> it's because of buggy bios. However, the linux kernel doesn't handle properly
> such case. I've tested 2.4.30-pre1 kernel and latest 2.6.11-rc4 kernel.
> The conclusion is, that once the machine has physically installed 4x1GB
> DDR400 DIMM's (bios detects only 3556 or less memory as some buffers
> are allocated by the Intel 875P chipset and AGP card), the linux 2.6.11*
> runs up-to 18x slower than when only 2x1GB + 2x 512MB DDR memory is installed.
> 
Can you enable profiling and then post the profile info for various cases - slow and fast? Check out Documentation/basic_profiling.txt in the kernel source for understanding how to do this. This might help narrow down the issue.

Parag



