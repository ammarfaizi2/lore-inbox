Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSKUAhA>; Wed, 20 Nov 2002 19:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSKUAhA>; Wed, 20 Nov 2002 19:37:00 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56708 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265077AbSKUAg7>; Wed, 20 Nov 2002 19:36:59 -0500
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>, Bill Davidsen <davidsen@tmr.com>,
       Aaron Lehmann <aaronl@vitelus.com>, Con Kolivas <conman@kolivas.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021121000811.GQ23425@holomorphy.com>
References: <3DD0E037.1FC50147@digeo.com>
	<Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com>
	<3DDC1480.402A0E5B@digeo.com>  <20021121000811.GQ23425@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 01:11:32 +0000
Message-Id: <1037841092.5822.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 00:08, William Lee Irwin III wrote:
> Similar things have been reported with 2.4.x vs. 2.2.x and IIRC there
> was some speculation they were due to low-level arch code interactions.
> I think this merits some investigation. I, for one, am a big user of
> SIGIO in userspace C programs...

FSAVE v FXSAVE is one of the reasons for the 2.2/2.4 shift


