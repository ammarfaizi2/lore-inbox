Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318878AbSHSNMs>; Mon, 19 Aug 2002 09:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318879AbSHSNMs>; Mon, 19 Aug 2002 09:12:48 -0400
Received: from taco.vianet.on.ca ([209.91.128.11]:58505 "HELO smtp.vianet.ca")
	by vger.kernel.org with SMTP id <S318878AbSHSNMr>;
	Mon, 19 Aug 2002 09:12:47 -0400
Message-ID: <3D60EFC2.2080306@thirddimension.net>
Date: Mon, 19 Aug 2002 09:16:50 -0400
From: Reid Sutherland <reid-lkml@thirddimension.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Interrupt issue with 2.4.19 vs 2.4.18.
References: <3D5D527E.5030607@thirddimension.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm guessing since no one replied it's because either I did not provide 
enough details or the the problem itself specific to my hardware which 
no one has :)

In an effort to help out as much as I can, could someone shed some light 
on how I can debug this further?  What kernel debugging options should 
be enabled?  And how can I actually debug this since the system will not 
  boot while the problem is happening?

Thanks in advance!

-reid

(please note that 2.4.18 does work _without_ a hitch, but 2.4.19 fails)

Reid Sutherland wrote:
> Hi everyone,
> 
> I have a problem with the aic7xxx constantly retrying to initialize my 
> LVD SCSI drives.  I'm repeatedly getting a "Command already completed" 
> message.  It was mentioned to me that this might be an interrupt related 
> problem (thank you Justin!).
> 
> My board has a Intel 440GX chipset.  From my understanding these are a 
> bitch to deal with and are littered with bugs.  I've also read that by 
> enabling SMP or IO-APIC, it should solve this issue.  Well, neither does 
> it for me.
> 
> Does anyone know what could have changed between .18 and .19 that would 
> cause something like this to happen?
> 
> Any insight would be appreciated!
> 
> Thanks,
> 
> -reid
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



