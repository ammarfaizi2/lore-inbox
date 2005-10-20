Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbVJTAEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbVJTAEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 20:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbVJTAEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 20:04:52 -0400
Received: from deliverator6.gatech.edu ([130.207.165.168]:59620 "EHLO
	deliverator6.gatech.edu") by vger.kernel.org with ESMTP
	id S1751651AbVJTAEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 20:04:51 -0400
Message-ID: <4356DF14.7070804@mail.gatech.edu>
Date: Wed, 19 Oct 2005 20:04:36 -0400
From: Luke Albers <gtg940r@mail.gatech.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: USB-> bluetooth adapter problem
References: <43499A44.2070803@mail.gatech.edu> <1128898123.19569.28.camel@blade>
In-Reply-To: <1128898123.19569.28.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I have a 3com USB bluetooth adapter, that worked for  me at one time, 
>>that I can't get working anymore.
>>
>>The model is 3CREB96B
>>
>>Sometimes it isnt even noticed when I plug it in, but after restarting 
>>hotplug I get this:
>>
>>usb 4-1: new full speed USB device using uhci_hcd and address 2
>>hci_usb_probe: Can't set isoc interface settings
>>usb 4-1: USB disconnect, address 2
>>
>>I don't think that I have removed any options from the kernel that 
>>should cause this, and other USB devices work fine.
>>
>>Can someone please explain this message in more detail (google turns up 
>>very little)?
>>    
>>

I got another one of these adapters, and when I plug the new one in I get:

usb 4-1: new full speed USB device using uhci_hcd and address 2
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb
hcid[30219]: Bluetooth HCI daemon
hcid[30219]: HCI dev 0 up
hcid[30219]: Starting security manager 0

Then I remove that one and plug in the original and get the old problem:

usb 4-1: new full speed USB device using uhci_hcd and  address 3
hcid[30219]: HCI dev 0 registered
usb 4-1: USB disconnect, address 3
hcid[1984]: Can't init device hci0: No such device (19 )
hcid[30219]: HCI dev 0 unregistered

So the old one I was using seems to be a bad device, I just want to ask 
if there are any other possibilities, other than bad hardware, before I 
get rid of it.

Thanks




