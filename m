Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292429AbSBUPJM>; Thu, 21 Feb 2002 10:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292374AbSBUPI6>; Thu, 21 Feb 2002 10:08:58 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:25578 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S292444AbSBUPIN>;
	Thu, 21 Feb 2002 10:08:13 -0500
Message-ID: <3C750C9D.7090607@dplanet.ch>
Date: Thu, 21 Feb 2002 16:05:01 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Giacomo Catenazzi <cate@debian.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, andersen@codepoet.org,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.44.0202210655020.8696-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2002 15:08:11.0517 (UTC) FILETIME=[93EF62D0:01C1BAE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:

>>David Lang wrote:
>>
>>>2. does it handle the 'I want this feature, turn on everything I need for
>>>it'?
>>>
>>>3. if it handles #2 what does it do if you turn off that feature again
>>>(CML2 turns off anything it turned on to support that feature, assuming
>>>nothing else needs it)
> 
> #3 may be, but #2 isn't possible if the language doesn't provide enough
> info for the tool to know what is needed to make a feature work.


Ok. I agree, #2 is also a configuration language item.
(actual CML doesn't support #2).

It seems that actual language support #2:
you see that every symbol have a list of dependencies,
so a configuration tools can change these dependencies.

But also CML2 don't support #2 for strange/complex rules (<1%).
(It complains about unmet dependencies.) and we should
not support it for such rules (i.e. if a rules conflicts
with PCI or other rules that force BIG changes...).


	giacomo


