Return-Path: <linux-kernel-owner+w=401wt.eu-S1751322AbXANPu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbXANPu5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 10:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbXANPu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 10:50:56 -0500
Received: from mail.tmr.com ([64.65.253.246]:44119 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbXANPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 10:50:56 -0500
Message-ID: <45AA51D4.4030503@tmr.com>
Date: Sun, 14 Jan 2007 10:52:52 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Sunil Naidu <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com> <20070112150349.GI17269@csclub.uwaterloo.ca> <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>            <45A93E97.30007@tmr.com> <200701140155.l0E1tpkB009184@turing-police.cc.vt.edu>
In-Reply-To: <200701140155.l0E1tpkB009184@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sat, 13 Jan 2007 15:18:31 EST, Bill Davidsen said:
>> Valdis.Kletnieks@vt.edu wrote:
>>> On Fri, 12 Jan 2007 10:03:49 EST, Lennart Sorensen said:
>>>> I would expect any distribution should work on these (as long as the
>>>> kernel they use isn't too old.).  Of course if it is a Mac, you need a
>>>> distribution that supports their firmware (which is of course not a PC
>>>> bios).  As long as you can boot it, any i386 or amd64 kernel with smp
>>>> enabled should use all the processors present (well amd64 on the
>>>> core2duo and on the p4 if it is em64t enabled).
>>> amd64 will only work on a core2duo if it's a T7200 or higher - the
>>> lower numbers are 32-bit-only chipsets.  I admit not knowing what
>>> exact variant the Mac has.
>> I don't believe that's correct, the Intel features page indicates all 
>> core2 have both 64bit and virtualization. Perhaps some of the core (no 
>> 2) models didn't? Even the old 930 had those features by my notes.
> 
> My screwup - the chart I looked at managed to get the Core and Core2 series
> mixed up. Here's a hopefully more canonical one:
> 
> http://www.intel.com/products/processor_number/proc_info_table.pdf
> 
> Does however list some Core2 that don't do virtualization (page 3, the
> T5600 and T5500), which is what I think confused the author of the table
> that I misread. ;)

I missed those in terms of virtualization, but it seems that all core2 
support "intel 64" which I assume means emt64t, and what I thought 
Valdis meant by "the lower numbers are 32-bit-only chipsets." They all 
do seem to have 64bit, and should run 64bit Linux just fine.
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
