Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSLLKNs>; Thu, 12 Dec 2002 05:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSLLKNr>; Thu, 12 Dec 2002 05:13:47 -0500
Received: from k100-145.bas1.dbn.dublin.eircom.net ([159.134.100.145]:17668
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S262208AbSLLKNr>; Thu, 12 Dec 2002 05:13:47 -0500
Message-ID: <3DF86299.3080309@draigBrady.com>
Date: Thu, 12 Dec 2002 10:19:05 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
References: <Pine.LNX.3.96.1021211134909.19397B-100000@gatekeeper.tmr.com> <1039640441.18412.24.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1039640441.18412.24.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2002-12-11 at 18:51, Bill Davidsen wrote:
> 
>>Is this the CPU in the $200 "Lindows" PC Wal-Mart is selling? I was
>>thinking of one for a low volume router, and it looks as if there are two
>>VIA chips called C3 (or advertizers have hacked the specs).
> 
> It is. Its a nice CPU for appliances. FPU is nondescript, integer
> performance is sort of the same as an equivalently clocked celewrong for
> the current Ezra core at least. The older Samuel II core seems a little
> slower.
> 
> There is also a subspecies that comes in at 500-600MHz and is designed
> for low power fanless operation (though with a decent sized heatsink the
> same is true for the 1GHz ones).

Although don't try to do this in 1U with 1GHz chips unless you clock
down and reduce the voltage (you need a "fair amount" of free space 
above the heatsink to dissipate the heat). Hmm that reminds me I must 
complete the auto voltage selection code in cpufreq.

> If you think the Walmart PC is cool take a look at the EPIA board or see
> www.mini-itx.com. 60W for a complete PC

I built a "no moving parts" router thingy in 1U that used max 19W.
You get a nice MTBF (5.25 years for our config) when there's nothing
mechanical as well as a good power saving. The main parts were:

PSU: EOS VLT60-3000 (now celetron)
MB:  Advantech PCM9576
CPU: Ezra C3 866a
HD:  64MB compact flash

Pádraig.

