Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbSLPSj5>; Mon, 16 Dec 2002 13:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbSLPSj5>; Mon, 16 Dec 2002 13:39:57 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:2998 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267030AbSLPSj4> convert rfc822-to-8bit; Mon, 16 Dec 2002 13:39:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: L2 Cache problem
Date: Mon, 16 Dec 2002 19:47:31 +0100
User-Agent: KMail/1.4.3
References: <20021216133016.64c75cac.paxl@videotron.ca>
In-Reply-To: <20021216133016.64c75cac.paxl@videotron.ca>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Xavier LaRue <paxl@videotron.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212161947.02431.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 December 2002 19:30, Xavier LaRue wrote:

Hi Xavier,

> My linux kernel did'nt detect my L2 cache on any of my two cpu ( this is an
> smp box ) here is the /proc/cpuinfo: Therse processor are perfect Steping
> match SL3FJ( therse old katmai processor have 512k l2 cache ).
> And I get nothing in my dmesg about l2 cache ( 'dmesg | grep L2' give
> nothing ) I'm on an plain vanilla kernel ( 2.4.18 taken at kernel.org )
> with xfs-1.1 patch. At boot my bios say that my L2 of my two cpu are ok.
This is fixed in 2.4.21-pre1. You have to upgrade or play with this patch:

http://linux.bkbits.net:8080/linux-2.4/cset@1.757.30.17?nav=index.html|ChangeSet@-3w

I am afraid this will not apply clean ontop of 2.4.18.

ciao, Marc
