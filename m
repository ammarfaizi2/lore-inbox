Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVGXWQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVGXWQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 18:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVGXWQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 18:16:07 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:18581 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261441AbVGXWQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 18:16:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=beAWe1u/OAEnzxrQ5mAtqvkwh8U4MR32ne+OpmduwDvOxA500Hx9s8e8kRvaKnctCi2CLIgvvIwRbo0C2nrGWmJggI8ybUqzcr9/oZiQbSY+wwHLvyS+dTjrvYk5gamBifCsJAYjXxGVw3pkjwsjs5lL7ndQyeB3TMMByTV7N9w=
Message-ID: <42E4131D.6090605@gmail.com>
Date: Sun, 24 Jul 2005 18:15:57 -0400
From: Puneet Vyas <vyas.puneet@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Grant Coady <lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: xor as a lazy comparison
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr> <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com> <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>To confuse you, coders with assembly or hardware background throw in 
>>    
>>
>
>I doubt that. I'm good enough assembly to see this :)
>
>  
>
>>equivalent bit operations to succinctly describe their visualisation 
>>of solution space...  Perhaps the writer _wanted_ you to pause and 
>>think?  Maybe the compiler produces better code?  Try it and see.
>>    
>>
>
>It produces a simple CMP. Should not be inefficient, though.
>
>
>Jan Engelhardt
>  
>
I just compiled two identical program , one with "!=" and other with 
"^". The assembly output is identical.
