Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135235AbRDLR0R>; Thu, 12 Apr 2001 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135236AbRDLR0I>; Thu, 12 Apr 2001 13:26:08 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:45064 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S135235AbRDLRZy>;
	Thu, 12 Apr 2001 13:25:54 -0400
Date: Thu, 12 Apr 2001 19:25:44 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Let init know user wants to shutdown
To: pavel@suse.cz
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3AD5E518.3641B73A@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek (pavel@suse.cz) wrote :

> Hi! 
> 
> Init should get to know that user pressed power button (so it can do 
> shutdown and poweroff). Plus, it is nice to let user know that we can 
> read such event. [I hunted bug for few hours, thinking that kernel 
> does not get the event at all]. 
> 
> Here's patch to do that. Please apply, 
>                                                                 Pavel 

Isn't it better to just send the event to userspace , where
is it caught by apmd ( or whatever has replaced it ).
Then it can decide what to do about it, instead of dictating
a shutdown from kernel ( policy alert ;-) )


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
