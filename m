Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFZXZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFZXZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFZXZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:25:34 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:32539 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261409AbVFZXZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:25:25 -0400
Message-ID: <42BF3964.5010809@blueyonder.co.uk>
Date: Mon, 27 Jun 2005 00:25:24 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 USB Keypad still not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2005 23:26:03.0171 (UTC) FILETIME=[6B34CF30:01C57AA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henk Wrote:
 > Hi Sid,
 >
 > Search results for 'sk04'
 >
 > Documents 1 - 7 of 7 matches. More *'s indicate a better match.
 > **** LKML: Sid Boyce: Re: [PATCH] new driver for yealink usb-p1k phone
 > **** LKML: Sid Boyce: Re: [PATCH] new driver for yealink usb-p1k phone
 > *** LKML: Sid Boyce: Re: 2.6.12 USB Keypad still not working
 > *** LKML: Andrew Morton: Re: 2.6.12 USB Keypad still not working
 > *** LKML: Sid Boyce: 2.6.12 USB Keypad still not working
 > ** LKML: Sid Boyce: Re: [PATCH] new driver for yealink usb-p1k phone
 > ** LKML: Sid Boyce: RE: [PATCH] new driver for yealink usb-p1k phone
 >
 >
 > Well the yealink driver is specifically targeted for the USB-P1K from
 > Yealink, I would be suprised if it works with the SK04.
 >
 > Apart from that, the SK-04 manual seems to indicate that its a generic
 > HID keyboard with a generic USB sound card.
 >
 > I dont have a generic HID usb keyboard myself so I cant give you 
first > hand
 > infos.
 >
 >In any case its best to consult the linux-usb-* mailing lists.

 > Henk
I tried the Yealink patch on 2.6.12 with the same results. All kernels 
up to 2.6.12-git8 (without the yealink patch) recognise the keypad, it's 
registered in /sys and looks good, but udev doesn't seem to create a 
device for it. udev on SuSE 9.3 is 053, but probably is modified beyond 
figuring out exactly how it stacks up against 058.
  # less /sys/bus/usb/devices/usb3/3-2/3-2:1.3/interface
Keypad

The manufacturer's blurb says it works under Linux, but I can't get a 
reply from them.
Regards
Sid.
--
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
