Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHMIPj>; Tue, 13 Aug 2002 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSHMIPj>; Tue, 13 Aug 2002 04:15:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27151 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313305AbSHMIPi>; Tue, 13 Aug 2002 04:15:38 -0400
Message-ID: <3D58C0FB.1020503@zytor.com>
Date: Tue, 13 Aug 2002 01:19:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@actcom.co.il>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] __func__ -> __FUNCTION__
References: <3D58A45F.A7F5BDD@zip.com.au> <ajaa5h$61f$1@cesium.transmeta.com> <3D58BF90.56C75C66@zip.com.au> <20020813075944.GA2192@alhambra.actcom.co.il> <3D58BEC3.50508@zytor.com> <20020813081028.GB2192@alhambra.actcom.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Tue, Aug 13, 2002 at 01:09:39AM -0700, H. Peter Anvin wrote:
> 
>>Muli Ben-Yehuda wrote:
>>
>>>How about: 
>>>
>>>/* early gcc compilers lose on __func__ */ 
>>>#ifndef __func__ 
>>>#define __func__ __FUNCTION__
>>>#endif /* !defined __func__ */ 
>>
>>__func__ isn't a macro; it's a compiler token.
> 
> 
> Works for me(TM). 
> 

But it won't work on a compiler that actually *supports* __func__...

I think that is gcc 3.1 or higher, but I'm not the authority...

> ObCompleteyUnrelatedQuestions: where can I find klibc? 

ftp://ftp.kernel.org/pub/linux/libs/klibc/

	-hpa


