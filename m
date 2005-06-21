Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVFUEyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVFUEyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVFUEu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 00:50:26 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:49257 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261746AbVFUErA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 00:47:00 -0400
Message-ID: <42B79BC6.3010201@blueyonder.co.uk>
Date: Tue, 21 Jun 2005 05:47:02 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new driver for yealink usb-p1k phone
References: <42B7990D.8000500@blueyonder.co.uk>
In-Reply-To: <42B7990D.8000500@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jun 2005 04:47:40.0777 (UTC) FILETIME=[5AFF4D90:01C5761C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:
> I had to apply drivers/usb/Makefile and drivers/usb/input/Kconfig by 
> hand to 2.6.12, the rest applied ok.
> scripts/kconfig/conf -o arch/i386/Kconfig
> drivers/usb/input/Kconfig:213: syntax error, unexpected T_WORD
> drivers/usb/input/Kconfig:215: invalid menu option
> drivers/usb/input/Kconfig:216: syntax error, unexpected T_WORD
> drivers/usb/input/Kconfig:219: invalid menu option
> drivers/usb/input/Kconfig:219: syntax error, unexpected T_WORD
> drivers/usb/input/Kconfig:222: invalid menu option
> make[1]: *** [oldconfig] Error 1
> make: *** [oldconfig] Error 2
> 
> My phone is the SkypePhone SK-04 (without the LCD) and this patch seems 
> to address the problems I'm having such keypad not working, no ring or 
> hands free/headset audio, the mic works in all configurations. Currently 
> it only works through the handset. tech@phoneskype not responding to any 
> of my emails.
> It could be finger trouble, I shall look again when I've had some sleep.
> Regards
> Sid.

Oops, tabs were missing, it's building.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
