Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUKDO5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUKDO5G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKDO5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:57:06 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:39335 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262238AbUKDO5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:57:01 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 09:56:57 -0500
User-Agent: KMail/1.7
Cc: Paul Slootman <paul+nospam@wurtel.net>
References: <20041103194226.GA23379@DervishD> <20041104102655.GB23673@DervishD> <cmde0g$l20$1@news.cistron.nl>
In-Reply-To: <cmde0g$l20$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040956.57915.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.42.194] at Thu, 4 Nov 2004 08:57:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 09:23, Paul Slootman wrote:
>DervishD  <lkml@dervishd.net> wrote:
>>    If init is the parent, all works ok, just wait a bit and all
>>those zombies will really die ;)
>
>I recently had a system with serial console where some some reason
> the serial port was stopped. This meant that init blocked while
> writing some message (e.g. "respawning too rapidly"), and that
> meant it stopped reaping those zombie processes. The list of these
> zombie processes with PPID == 1 was amazing. The only thing that
> helped was rebooting after replacing the serial console cable.
>
>(Kernel 2.4.25, sysvinit 2.85 in case you're wondering.)

Both serial ports are already in use here Paul, one for heyu and x10 
stuff related to my home automation (mostly the outside lights), and 
the other to my Belkin ups, whose usb interface has never worked, so 
I'm stuck using serial for the BullDog interface to gkrellm.  I'd 
like to find a cheap pci rocketport as I have another vintage box in 
the basement that could use this machine as a network gateway then.  
Right now its on PL2303 usb<->serial convertor but somethings wrong 
with the handshaking on that end.

>Paul Slootman
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
