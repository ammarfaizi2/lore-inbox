Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264939AbUEYQCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbUEYQCV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUEYQCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:02:21 -0400
Received: from mail.kssb.net ([198.248.45.1]:47292 "EHLO california.campus")
	by vger.kernel.org with ESMTP id S264939AbUEYQCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:02:16 -0400
Message-ID: <40B36E0B.3090605@kssb.net>
Date: Tue, 25 May 2004 11:02:19 -0500
From: Bradley Hook <bhook@kssb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085468812.2783.7.camel@laptop.fenrus.com> <B58A76BA-AE60-11D8-BD27-000A95CC3A8A@mesatop.com>
In-Reply-To: <B58A76BA-AE60-11D8-BD27-000A95CC3A8A@mesatop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2004 16:02:17.0441 (UTC) FILETIME=[A70A1510:01C44271]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> On May 25, 2004, at 1:06 AM, Arjan van de Ven wrote:
> 
>>
>>
>>> explanation part of the patch. That sign-off would be just a single line
>>> at the end (possibly after _other_ peoples sign-offs), saying:
>>>
>>>     Signed-off-by: Random J Developer <random@developer.org>
>>
>>
>> well this obviously needs to include that you signed off on the DCO and
>> not some other random piece of paper, and it probably should include the
>> DCO revision number you signed off on.
>> Without the former the Signed-off-by: line is entirely empty afaics,
>> without the later we're not future proof.
>>
>>
> 
> How about something like:
> 
>     DCO 1.0 Signed-off-by: Random J Developer <random@developer.org>
> 
> This new process being "an ounce of prevention is worth a pound
> of cure" should retain the property of being lightweight and not
> unduly burdensome.  This change seems to fall into that category.
> 
>     Steven  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Why not design the DCO so that it assumes an author accepts the most 
recent published version unless specified. You could then shorten the 
line to:

DCO-Sign-Off: Random J Developer <random@developer.org>

And if they wanted to specify a version, use something like:

DCO-Sign-Off: Random J Developer <random@developer.org> [DCO 1.0]

You could also define the signoff line to use different delimiters for 
various types of information, to allow for all of these "custom" ideas 
that contributing companies may feel they "need".

For example, say any text not enclosed by any delimiters is considered a 
name, anything in <> is an email, in [] is a DCO version, and {} allows 
for optional information. This would allow for stuff like Yarroll 
submitted while I was typing this email, for example:

DCO-Sign-Off: La Monte H.P. Yarroll <piggy@timesys.com> [DCO 1.0] {TS00062}

Nothing other than name and email would be required, but they would be 
available for those that wish to use them. This would make it easy for 
scripts to sort out the info on this line.

~Brad
