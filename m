Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFTQfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFTQfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFTQfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:35:09 -0400
Received: from styx.suse.cz ([82.119.242.94]:32189 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261250AbVFTQe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:34:57 -0400
Date: Mon, 20 Jun 2005 18:34:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: IBM HDAPS Someone interested?
Message-ID: <20050620163456.GA24111@ucw.cz>
References: <20050620155720.GA22535@ucw.cz> <005401c575b3$5f5bba90$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005401c575b3$5f5bba90$600cc60a@amer.sykes.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 10:16:09AM -0600, Alejandro Bonilla wrote:

> I was told, that the only thing that was needed was an ADD card. ( Analog to
> Digital?)

Indeed, but there is a zillion of different approaches to an A/D.
I'm quite sure IBM have rolled their own directly on the mainboard.

The main question is on which bus and which address it lives and what is
the programming interface. It's not something Analog Devices would know.

It can be on some monitoring chip living on the SMBus (most likely) or
coupled directly to the ACPI bridge on PCI, or anywhere else in the
system.

> If you are interested, I can call you and then conference Analog Devices,
> and they will tell you what is needed, I bet IBM did whatever Analog Devices
> told them to do. And they might even tell us what to do if they talk with
> someone that knows (I was bumbling, while he was talking about all the IO
> and G rates)

Well, I will not be interested until I'm convinced they'll be able to
tell me something I don't know already.

> I don't think they have anything in the BIOS related to the HDAPS, else they
> would have put something in it. (You can't even disable the chip in the
> BIOS) I just think is the accelerometer, there, by itself with an extra card
> they added.
 
Well, some piece of software needs to park the HDD when the notebook is
falling, and that piece of software should better be running since the
notebook is powered on. Hence my suspicion it's in the BIOS. It doesn't
have to be visible to the user, at all.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
