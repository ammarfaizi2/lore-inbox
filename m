Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUCHVJZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUCHVJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:09:25 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:2763 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261244AbUCHVJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:09:21 -0500
Message-ID: <404CE0FC.8070900@stesmi.com>
Date: Mon, 08 Mar 2004 22:09:16 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
References: <404C4D32.1080609@uni-paderborn.de> <200403081714.04182.bernd.schubert@pci.uni-heidelberg.de> <404CD4E7.5050105@uni-paderborn.de>
In-Reply-To: <404CD4E7.5050105@uni-paderborn.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Hello,
>>> is there a way to measure/change the fsb of a PII/233/Tonga/440BX while
>>> running linux? Google has no answer...
>>
>>
>>
>> This is the only one I know about, but it has support for a few 
>> boards/pll's only.
>>
>> http://home.iprimus.com.au/mccvals/mvpll/
>>
>> Hope it helps,
>>     Bernd
> 
> 
> Hello and thank you for your answer. I determined that this cpu has a 
> fsb of
> 66MHz. The reason for my question was that i want to underclock the cpu.
> I think it would be better to change the multiplier instead of changing 
> the fsb.
> Therefore i read the msr register 0x02ah, tilted bit 27 and wrote it 
> back, but
> the cpu clock is still the same. Why does that not work? Is it possible to
> change the multiplier at runtime at all?
> 

I'm no expert on the subject but as I recall the processor sets the
internal clock (derived from fsb+multiplier) on startup so no matter
what you do do the running cpu it won't change it.

// Stefan
