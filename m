Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267698AbSLGBsl>; Fri, 6 Dec 2002 20:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267700AbSLGBsl>; Fri, 6 Dec 2002 20:48:41 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:49075 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267698AbSLGBsk>; Fri, 6 Dec 2002 20:48:40 -0500
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Norman Gaywood <norm@turing.une.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021207014643.GW9882@holomorphy.com>
References: <3DEFFEAA.6B386051@digeo.com>
	<20021206014429.GI1567@dualathlon.random>
	<20021206021559.GK9882@holomorphy.com>
	<20021206022853.GJ1567@dualathlon.random>
	<20021206024140.GL9882@holomorphy.com>
	<20021206222852.GF4335@dualathlon.random>
	<20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com>
	<20021207002133.GT9882@holomorphy.com>
	<1039227589.25062.10.camel@irongate.swansea.linux.org.uk> 
	<20021207014643.GW9882@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Dec 2002 02:31:37 +0000
Message-Id: <1039228297.25045.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 01:46, William Lee Irwin III wrote:
> It's an arch parameter, so they'd probably just
> #define MMUPAGE_SIZE PAGE_SIZE
> Hugh's original patch did that for all non-i386 arches.

These are low end x86 - but we could this based on

	<= i586
	i586
	i686+

