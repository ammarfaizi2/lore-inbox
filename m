Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbSLGBg5>; Fri, 6 Dec 2002 20:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbSLGBg5>; Fri, 6 Dec 2002 20:36:57 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:46515 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267697AbSLGBg4>; Fri, 6 Dec 2002 20:36:56 -0500
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Norman Gaywood <norm@turing.une.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021207002133.GT9882@holomorphy.com>
References: <3DEFF69F.481AB823@digeo.com>
	<20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com>
	<20021206014429.GI1567@dualathlon.random>
	<20021206021559.GK9882@holomorphy.com>
	<20021206022853.GJ1567@dualathlon.random>
	<20021206024140.GL9882@holomorphy.com>
	<20021206222852.GF4335@dualathlon.random>
	<20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com> 
	<20021207002133.GT9882@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Dec 2002 02:19:49 +0000
Message-Id: <1039227589.25062.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 00:21, William Lee Irwin III wrote:
> 16K is reasonable; after that one might as well go all the way.
> About the only way to cope is amortizing it by cacheing zeroed pages,
> and that has other downsides.

Some of the lower end CPU's only have about 12-16K of L1. I don't think
thats a big problem since those aren't going to be highmem or large
memory users 

