Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTLMEDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 23:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTLMEDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 23:03:13 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:45842 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263645AbTLMEDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 23:03:09 -0500
Message-ID: <3FDA8F5F.1030506@nishanet.com>
Date: Fri, 12 Dec 2003 23:02:39 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test11 ps2 mouse giving corrupt data?
References: <200312121236.38692.andrew@walrond.org> <20031212141521.GA27405@ucw.cz>
In-Reply-To: <20031212141521.GA27405@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Fri, Dec 12, 2003 at 12:36:38PM +0000, Andrew Walrond wrote:
>  
>
>>I have just switched from l2.4 to 2.6 on my thinkpad, and the mouse does 
>>something wierd when I boot into x (kde)
>>
>>startx, then wait for everything to load, then move mouse. Mouse goes crazy, 
>>menus pop up everywhere as though I were pressing buttons, and after about 3 
>>seconds, it all settles down and works perfectly.
>>    
>>
>
>Most likely X does something nasty to the keyboard controller while it
>is starting up. The psmouse kernel driver has an autosync feature which
>can get it out of trouble if you don't move the mouse for two seconds.
>  
>
When did the autosync feature arrive?
It doesn't work for me(k2.6.11 with
MSI K7N2 Delta nforce2 mboard
and k2.6.11 with Shuttle Xpc SK41G
FX41 mboard with VIA fsb) if ps2
kvm switch(Belkin) is switched away.

When sync is lost on my pc's I have to
reboot. Symptoms are the same, on X or
text term--any mouse movement triggers
selects and buttons down but the correct
events do not occur.

With a kvm switch k-2.6.? loses psmouse
sync on the off pc. Rebooting is the only
solution. I got tired of this and moved the
mouse(logitech trackman fx) to one pc,
so the other only has to boot with the
mouse attached either to kvm or ps2
port on pc. That's fine until moving the
mouse back and forth for rebooting
causes the pc with X running to lose
sync. Then it can't regain sync.

-Bob
