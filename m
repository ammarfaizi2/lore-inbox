Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269178AbRHTUct>; Mon, 20 Aug 2001 16:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269206AbRHTUc3>; Mon, 20 Aug 2001 16:32:29 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:6922 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S269178AbRHTUc0>; Mon, 20 Aug 2001 16:32:26 -0400
Message-Id: <200108202032.f7KKWcY42028@aslan.scsiguy.com>
To: A.J.Scott@casdn.neu.edu
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 aic7xxx -- continuous bus resets 
In-Reply-To: Your message of "Mon, 20 Aug 2001 11:12:27 EDT."
             <3B80F09A.8507.A8DAED@localhost> 
Date: Mon, 20 Aug 2001 14:32:38 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2.4.9 has the latest aic7xxx driver in it.  Can you see if that changes
>> things for you?  If not, can you hook up a serial console to the machine
>> and provide all of the messages from an aic7xxx=verbose boot?
>
>Ok, tried 2.4.9. With 1 ioapic the machine boots just fine. With the 
>second ioapic enabled the behavior I previously described still 
>occurs.
>
>attempting to Queue abort
>aic7xxx_abort returns 8194
>
>These are the only error messages I copied down, I believe that there 
>was another, will reboot and check later.

Yup.  The driver is not seeing interrupts.

--
Justin
