Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263509AbSITUHB>; Fri, 20 Sep 2002 16:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263511AbSITUHB>; Fri, 20 Sep 2002 16:07:01 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:23432 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263509AbSITUG7>; Fri, 20 Sep 2002 16:06:59 -0400
From: latten@austin.ibm.com
Date: Fri, 20 Sep 2002 15:12:05 -0500
Message-Id: <200209202012.g8KKC5f40542@faith.austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re:Problems with 2.4 and 2.5 with KVM/mouse
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the same problem. I am using a Belkin OmniView 4-port KVM switch and
a regular IBM 3-button ps2 mouse. My KVM switch is
hooked between two linux boxes. One box is running linux 2.4.19
kernel and the other linux 2.5.34. Whenever I swap over, the 2.5
machine  will not work with the mouse. I see the same behaviour
as reported and must reboot. Restarting gpm doesn't help...
However, I have no problems with the 2.4 machine
whenever I swap over. I only see this with 2.5. I also had 2.5.31
installed and saw the same wacky behaviour.
Prior to installing 2.5, both boxes had versions of 2.4 running
and I didn't have any problems swapping over with the KVM switch on either. 
I also am running gnome desktop on both machines.

Joy Latten

PS Please mail any response directly to me as I am not subscribed to 
the mailing list. Thanks.


>I do remember that I have one board in my company that doesn't like KVMs 
>at all (please don't ask for the brand, I'm offsite for a while and 
>don't remember the type). All other boards connected to KVMs (different 
>types) and running Linux 2.4 (various versions) work fine.
>So I guess you do have a hardware (board) problem.
>
>Stephen Hemminger wrote:
>> No change when gpm is killed and restarted
>> 
>> On Mon, 2002-09-16 at 11:56, Stephen Aiken wrote:
>> 
>>>>Now, on my test machine running 2.5 the mouse works until I do a KVM
>>>>machine swap. Then the 2.5 machine never clears up the mouse wackiness
>>>>and the only choice is to reboot. 
>>>
>>>Have you tried restarting gpm?
>>>
>>>-Steve
>>>--
>>>The day after tomorrow is the third day of the rest of your life.
>> 
>> 
>> 
>-- 
>Andreas Steinmetz
>D.O.M. Datenverarbeitung GmbH
