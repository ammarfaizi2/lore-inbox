Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbWEXKpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWEXKpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 06:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWEXKpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 06:45:17 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:39585 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932674AbWEXKpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 06:45:16 -0400
Message-ID: <4474392F.1030809@gmail.com>
Date: Wed, 24 May 2006 13:45:03 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
References: <20060515211229.521198000@gmail.com>	<20060515211506.783939000@gmail.com> <20060517222007.2b606b1b.akpm@osdl.org> <4471E259.7080609@gmail.com>
In-Reply-To: <4471E259.7080609@gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula wrote:
> Andrew Morton wrote:
> 
>>Anssi Hannula <anssi.hannula@gmail.com> wrote:
>>
>>
>>>Implement a new force feedback interface, in which all non-driver-specific
>>>operations are separated to a common module. This module handles effect type
>>>validations, effect timers, locking, etc.
>>>
>>>As a result, support is added for gain and envelope for memoryless devices,
>>>periodic => rumble conversion for memoryless devices and rumble => periodic
>>>conversion for devices with periodic support instead of rumble support. Also
>>>the effect memory of devices is not emptied if the root user opens and closes
>>>the device while another user is using effects. This module also obsoletes
>>>some flawed locking and timer code in few ff drivers.
>>>
>>>The module is named ff-effects. If INPUT_FF_EFFECTS is enabled, the force
>>>feedback drivers and interfaces (evdev) will be depending on it.
>>>
>>>Userspace interface is left unaltered.
>>>
>>
>>
>>Nice-looking patches.
>>
> 
> 
> Thanks for looking and providing helpful comments :)
> 

Andrew, did you get my response? I received Delivery Status Notification
for your address:
<copy>
- These recipients of your message have been processed by the mail server:
akpm@osdl.org; Failed; 5.3.0 (other or undefined mail system status)

    Remote MTA smtp.osdl.org: network error


 - SMTP protocol diagnostic: 554 5.7.1 gmail.com suggested we reject
your email: 81.228.11.120 is neither permitted nor denied by domain of
anssi.hannula@gmail.com
</paste>


> 
> BTW, what is the best way to send corrected patches for this patchset?
> Probably as a reply to the individual patches?
> 

Hmm, I think it is easier to just send the whole updated set...

I'm going to do all the changes discussed and then send the set probably
tomorrow or in the weekend.


-- 
Anssi Hannula

