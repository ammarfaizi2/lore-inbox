Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbTA3PlL>; Thu, 30 Jan 2003 10:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267525AbTA3PlL>; Thu, 30 Jan 2003 10:41:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7560
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267524AbTA3PlL>; Thu, 30 Jan 2003 10:41:11 -0500
Subject: Re: timer interrupts on HP machines
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: praveen.ray@crcnet1.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301300934.54201.praveen.ray@crcnet1.com>
References: <200301300934.54201.praveen.ray@crcnet1.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043945075.31674.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 16:44:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 14:34, Praveen Ray wrote:
> We have few HP (LPR NetServers and LT6000) which run 2.4.18  (from RedHat 8.0) 
> . The problem is that sometimes the time interrupts stop coming - i.e. the 
> (time) counts in /proc/interrupts stop getting incremented! When this 
> happens, the date on the system falls behind, 'sleep' calls stop working and 
> basically machine becomes unusable.Has anyone else encountered this problem? 
> Is it an HP issue?

That I don't know ut my first question other than the usual "Have you applied
the errata kernels" is probably whether its hitting some of the APIC funnies
older hw occasionally has. Are they stable running "noapic" ?

