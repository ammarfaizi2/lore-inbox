Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUIPO2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUIPO2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUIPO2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:28:25 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:15488 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S268095AbUIPO2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:28:20 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Date: Thu, 16 Sep 2004 15:28:19 +0100
User-Agent: KMail/1.7
Cc: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409161448.39033.andrew@walrond.org> <Pine.LNX.4.58.0409162358570.26494@fb07-calculator.math.uni-giessen.de>
In-Reply-To: <Pine.LNX.4.58.0409162358570.26494@fb07-calculator.math.uni-giessen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161528.19409.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Sep 2004 15:09, you wrote:
> AW> Typo? Tyan Thunder?
>
> no, it's a tiger: http://www.tyan.com/products/html/tigerk8w.html

Ah - ok; I thought the Tiger was their dual athlon board. Didn't realise they 
had a dual opteron version.

I have a Thunder K8W.

>
> AW> The option you mention should be set to 'Auto'
> AW>
> AW> Chipset->Northbridge->Memory Configuration->Adjust Memory = Auto
> AW>
> AW> but set
> AW>
> AW> Advanced->Cpu Configuration->MTRR Mapping = Continuous
>
> I had "MTRR Mapping = Continuous" set all the time and tried "Adjust
> Memory" in all three modes (Auto/manual/disabled) and manual with 1 and
> 2gb size.
>
> today I had discovered the MTRR option and changed it to "discrete".
> tried "Adjust Memory" manually at 2gb.
>
> the only working (but with loss of memory) combination seems to be "Adjust
> Memory = disabled" and independant of "MTRR Mapping".
>
> The only combination I didn't try is "MTRR Mapping=Discrete"+"Adjust
> Memory= Auto". Will try tomorrow morning.
>

On further investigation, The settings I mentioned, 'Auto' and 'Continuous' 
only work when running a 64bit kernel. Are you running a 32bit kernel?

Andrew
