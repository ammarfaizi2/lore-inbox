Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUB0HRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbUB0HRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:17:40 -0500
Received: from snota.svorka.net ([194.19.72.11]:6051 "HELO snota.svorka.net")
	by vger.kernel.org with SMTP id S261744AbUB0HQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:16:23 -0500
Message-ID: <403EEEB9.5030408@svorka.no>
Date: Fri, 27 Feb 2004 08:16:09 +0100
From: Jo Christian Buvarp <jcb@svorka.no>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Enrico Demarin <enricod@videotron.ca>, linux-kernel@vger.kernel.org,
       "Moore, Eric Dean" <Emoore@lsil.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Ibm Serveraid Problem with 2.4.25
References: <403DB882.9000401@svorka.no> <1077839333.4823.5.camel@localhost.localdomain> <1077846502.4454.2.camel@localhost.localdomain> <Pine.LNX.4.58L.0402270011140.2029@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402270011140.2029@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, I only got IBM ServeRAID support

--------------------------------------------------------------
Med vennlig hilsen/Yours sincerely
Jo Christian Buvarp
Teknisk Leder
Svorka Aksess AS

Notice:
This e-mail may contain confidential and privileged material for the sole use of the intended recipient. Any review or distribution by others is strictly prohibited. If this e-mail is received by others than the intended recipient, please contact the sender and delete all copies.



Marcelo Tosatti wrote:

>Jo,
>
>You're also using the MPT Fusion driver?
>
>It has been updated in 2.4.25, and probably something broke. DAMN.
>
>Eric, please look into this for us ?
>
>On Thu, 26 Feb 2004, Enrico Demarin wrote:
>
>  
>
>>Hi everyone,
>>
>>I just checked, same message on a IBM x235 , it uses the
>>
>>Fusion MPT SCSI Host driver 2.05.11.03
>>
>>driver.
>>
>>Same message as you  ( except the offsets vary ) when I reboot.
>>
>>- Enrico
>>
>>On Thu, 2004-02-26 at 18:48, Enrico Demarin wrote:
>>    
>>
>>>I have the same here using the "partially opensource" drivers for a
>>>Promise TX2... no message on 2.4.24.I wonder if it also means it's
>>>corrupting the FS ? :(
>>>
>>>
>>>- Enrico
>>>
>>>On Thu, 2004-02-26 at 04:12, Jo Christian Buvarp wrote:
>>>      
>>>
>>>>Just upgraded my server with the 2.4.25 kernel and I noticed an error :/
>>>>The server is an IBM 345 with a Serveraid 5I controller, when doing an
>>>>dmesg i get this error:
>>>>
>>>>attempt to access beyond end of device
>>>>08:05: rw=0, want=528036, limit=528034
>>>>attempt to access beyond end of device
>>>>08:09: rw=0, want=65208120, limit=65208118
>>>>
>>>>This error only shows up in 2.4.25, when rebooting to 2.4.24 everything
>>>>looks fine :)
>>>>I tried upgrading the serveraid bios to the newest version (6.11.07),
>>>>but i still got the error.
>>>>
>>>>So is this an bug in the kernel? Or do I have a problem on my server ?
>>>>Is it safe to run 2.4.25 with this error ? Or should i go back to 2.4.24
>>>>        
>>>>

