Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbRL3XP4>; Sun, 30 Dec 2001 18:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285668AbRL3XPq>; Sun, 30 Dec 2001 18:15:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16655 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285666AbRL3XPf>; Sun, 30 Dec 2001 18:15:35 -0500
Message-ID: <3C2FA013.4040000@zytor.com>
Date: Sun, 30 Dec 2001 15:15:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: robert@schwebel.de
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: AMD SC410 boot problems with recent kernels
In-Reply-To: <Pine.LNX.4.33.0112302247150.3056-100000@callisto.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:

> On 23 Dec 2001, H. Peter Anvin wrote:
> 
>>#ifdef CONFIG_SC410 time?
>>
> 
> What would be the best place to include this into the kernel config
> scheme?  Make an option, e.g. 'AMD Elan SC410 support' in "Processor type
> and features"?
> 


All of this is really a chipset issue, not a processor issue; I think it 
should go in the same place as "Toshiba laptop support" and such...


> I'll make an update for my SC410 patchlet on
> 
>   http://www.schwebel.de/software/dnp/index_en.html
> 
> during the next days, to add the fix for the serial port bug and the A20
> problem.
> 
> Do these problems (A20, serial port, timer) only exist on AMD's SC410
> chips or are they also present on the SC520s?


Don't know.  Perhaps someone at AMD can say?

	-hpa


