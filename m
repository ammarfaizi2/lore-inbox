Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUGLRwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUGLRwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUGLRuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:50:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22731 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266903AbUGLRts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:49:48 -0400
Date: Sun, 11 Jul 2004 16:14:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org,
       "Surendra I." <surendrai@esntechnologies.co.in>,
       "Subramanyam B." <subramanyamb@esntechnologies.co.in>
Subject: Re: Power Management in Linux
Message-ID: <20040711141452.GE607@openzaurus.ucw.cz>
References: <4EE0CBA31942E547B99B3D4BFAB34811038B3B@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811038B3B@mail.esn.co.in>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have installed SuSe linux 9.1 on my HP Laptop. I was wondering if
> Hibernation is supported in SuSe linux 9.1.  If yes, how to enable it?
> Please instruct me the steps to enable Hibernation.

Read Documentation/power.
 
> Also, I am developing a block driver for a PCI device under kernel
> 2.6.x.x. I would like to add PM features like Suspend, Wakeup and
> Hibernation in Block driver. I have seen few character drivers
> implementing PM features using pci_module_init()function. Will this
> function work for Block devices? Also, there is no callback for
> Hibernation, why?

See b44.c for example how to do pm.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

