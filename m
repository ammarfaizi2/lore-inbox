Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUCHVOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbUCHVOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:14:55 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:4299 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261239AbUCHVOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:14:54 -0500
Message-ID: <404CE248.4050002@stesmi.com>
Date: Mon, 08 Mar 2004 22:14:48 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Bjoern Schmidt <lucky21@uni-paderborn.de>, linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
References: <404C4D32.1080609@uni-paderborn.de> <200403081714.04182.bernd.schubert@pci.uni-heidelberg.de> <404CD4E7.5050105@uni-paderborn.de> <Pine.LNX.4.58.0403081545200.29087@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403081545200.29087@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> On Mon, 8 Mar 2004, Bjoern Schmidt wrote:
> 
> 
>>Hello and thank you for your answer. I determined that this cpu has a fsb of
>>66MHz. The reason for my question was that i want to underclock the cpu.
>>I think it would be better to change the multiplier instead of changing the fsb.
>>Therefore i read the msr register 0x02ah, tilted bit 27 and wrote it back, but
>>the cpu clock is still the same. Why does that not work? Is it possible to
>>change the multiplier at runtime at all?
> 
> 
> No, the multiplier is locked, you'll have more luck fiddling with the
> front side bus.

That would be the first P2/233 with a locked multiplier I've come
across. My P2's ranging from 233 to 350 were never multiplier locked
anyway. Celerons and P3's were multiplier locked however, maybe that's
what you're thinking about.

// Stefan
