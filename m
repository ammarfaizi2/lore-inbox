Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbSLEV0W>; Thu, 5 Dec 2002 16:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267489AbSLEVZq>; Thu, 5 Dec 2002 16:25:46 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:1422 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id <S267445AbSLEVC6>;
	Thu, 5 Dec 2002 16:02:58 -0500
Message-ID: <3DEFC0AF.1010601@stesmi.com>
Date: Thu, 05 Dec 2002 22:10:07 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Byron Albert <byron@markerman.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: host buss on p4 xeon
References: <3DEFBEB7.9080500@markerman.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Byron

> I am testing some new dual 2.4/2.8ghz Xeon DP boxes. They all have the 
> ServerWorks GC -LE Chipset. I was looking at the dmesg out put and it 
> says that the host buss is 100mhz but I in all the docs about the mother 
> board it says it should 400. Is this some other number or is there some 
> patches I need to get the faster bus speeds?

Strictly speaking your docs are lying.

The Pentium4 and Xeon CPUs use a 100 or 133Mhz quad-pumped bus. Transfer 
4 items of data per clock getting an effective bandwidth of 400MHz at 
100MHz or 533 at 133MHz.

// Stefan

