Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVKSIlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVKSIlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 03:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVKSIlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 03:41:11 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:39526 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750922AbVKSIlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 03:41:10 -0500
Message-ID: <437EE4B3.2090408@samwel.tk>
Date: Sat, 19 Nov 2005 09:39:15 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz>
In-Reply-To: <20051118232019.GA2359@spitz.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> My laptop also has a spindown (five min from memory) and I have yet to 
>> have a problem with it. Don't know if any of that is "spindowns without 
>> laptopmode" in a useful sense.
> 
> Unless you can also reproduce the failure... no, probably does not help
> much.

Okay, let's recap.

* There are a lot of people who are not having problems. The people who 
*are* having problems can usually reproduce them. My interpretation: the 
problem is triggered by some hardware and/or kernel config settings.

* A significant proportion of the people who *do* have trouble see 
messages about DMA timeouts. The problems do also occur on other 
hardware, but seem to be most pronounced on Thinkpad T40s. On those 
machines, the DMA timeout problems are triggered *especially* when the 
madwifi drivers are loaded (see 
http://bugzilla.ubuntu.com/show_bug.cgi?id=6108).

Perhaps I should start collection kernel configs and hardware specs, see 
if there are any unexpected commonalities. The influence of the madwifi 
drivers suggest that we could be be looking for anything really. What do 
you think?

--Bart
