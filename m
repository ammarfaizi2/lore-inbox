Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265481AbTFVDgC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 23:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTFVDgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 23:36:01 -0400
Received: from polaris.galacticasoftware.com ([206.45.95.222]:51074 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id S265481AbTFVDgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 23:36:00 -0400
From: Adam Majer <adamm@galacticasoftware.com>
Date: Sat, 21 Jun 2003 22:41:32 -0500
To: dave.bentham@ntlworld.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 crash
Message-ID: <20030622034132.GA4854@galacticasoftware.com>
References: <200306162148.h5GLmXsN002578@telekon.davesnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306162148.h5GLmXsN002578@telekon.davesnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 10:48:33PM +0100, dave.bentham@ntlworld.com wrote:
> Hello
> 
> But there seems to be a major failure when the computer just stops with no warning. Two scenarios that seem to repeat it include starting Loki's Heretic2 off, and mounting the CDRW drive via WindowMaker dock app. I cannot do anything when this happens; can't hotkey out of X, can't telnet to it from my other networked PC. I have to power down and back up.

There was something like this posted on the list a few days ago. Someone
said that it has to do with IDE-SCSI timing or what not. That is, try if you can
reproduce it without the ide-scsi driver in the kernel..

> It seems to be a few seconds after the trigger that the lock up occurs, and also it starts flashing the keyboard Caps Lock and Scroll Lock LEDs in step at about 1 Hz. I'm sure its trying to tell me something...

That means the kernel detected something evil (oops caused by null pointer access,
etc...). Sicne the leds are still flashing, at least the kernel is not totally dead. :)

hope this helps a bit,
- Adam

