Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVALTEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVALTEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVALTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:01:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:7555 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261293AbVALTAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:00:20 -0500
Message-ID: <41E572C0.2000909@osdl.org>
Date: Wed, 12 Jan 2005 10:56:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 errors on attempted insmod
References: <200501120000.15177.gene.heskett@verizon.net>
In-Reply-To: <200501120000.15177.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> I just bought a Sony HandyCam DCR-TRV460, which has both firewire and 
> usb ports.
> 
> But I couldn't seem to open a path to it using usb, so I plugged in an 
> old firewire card that has the TI-Lynx chipset on it.  Its recognized 
> (apparently) by both dmesg and kudzu, but although I'd turned on all 
> the 1394 stuff as modules when I got ready to plug the card in and 
> rebuilt my 2.6.10-ac8 kernel, kudzu didn't load any of them, and when 
> I try to, I'm getting "-1 Unknown Symbol in module" errors. 
> 
> Probably an attack of dumbass, but I'd appreciate any help that can be 
> tossed my way.  ATM I'm rebuilding again with the base module built 
> in.

Use modprobe instead of insmod, then there should be a logged message
about what symbol was missing/unknown.  Post that.

-- 
~Randy
