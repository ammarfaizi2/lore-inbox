Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUE2IrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUE2IrC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUE2Iqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:46:32 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:6546 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264196AbUE2IqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:46:19 -0400
Message-ID: <40B84DD3.7090505@yahoo.com.au>
Date: Sat, 29 May 2004 18:46:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matthias Schniedermeyer <ms@citd.de>
CC: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: MM patches (was Re: why swap at all?)
References: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <200405291031.02564.vda@port.imtp.ilyichevsk.odessa.ua> <40B84C85.8010207@yahoo.com.au>
In-Reply-To: <40B84C85.8010207@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Denis Vlasenko wrote:
> 
>> (pages with program/library code, data of e.g. your Mozilla, etc),
>> please submit a report to lkml. VM gurus said more than once
>> that they _want_ to fix things, but need to know how to reproduce.
> 
> 
> Yep.
> 
> Thanks to everyone's input I was able to test and adapt my mm work.
> It is hopefully at a stage where it can have wider testing now. It
> is stable on my SMP system under very heavy swapping, but the usual
> caution applies.
> 
> Test is 4 x cat 8GB > /dev/null (aggregate 100-200MB/s!) while in X,
> with xterms and mozilla open browsing and grepping kernel tree, etc.
> 

This isn't the "very heavy swapping" load, BTW :)

The very heavy swapping load is make -j15 in 64MB of memory.
