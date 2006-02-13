Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWBMUwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWBMUwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWBMUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:52:08 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:44461
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964868AbWBMUwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:52:07 -0500
Subject: Re: PPP with PCMCIA modem stalls on 2.6.10 or later
From: Paul Fulghum <paulkf@microgate.com>
To: Kouji Toriatama <toriatama@inter7.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060213.231636.103125334.toriatama@inter7.jp>
References: <20060213.231636.103125334.toriatama@inter7.jp>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 14:51:59 -0600
Message-Id: <1139863919.3868.16.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 23:16 +0900, Kouji Toriatama wrote:
> I am trying to run pppd with high speed PCMCIA modem on an
> IBM Thinkpad T41 laptop.  My Linux system is Debian (sarge)
> with vanilla kernel such as 2.6.15.4.

What make and model of PCMCIA modem?

Are any special drivers used?
(what is output of /proc/modules)

What resources (IO/IRQ) are used by the device
in 2.6.9 (working) and 2.6.10+ (problem)?

What is the output of /proc/interrupts and
/proc/tty/driver/serial between the two versions?

> The problem is PPP connection through the modem stalls at
> frequent intervals.  (To be exact, the PPP connection means
> TCP traffic such as SSH, HTTP.)

What applications are running and how are you
determining that there is a stall?

Does the stall persist until disconnect or
does data start flowing again after a while?

Can you tell if the transmit or receive side
is stalling (looking at ifconfig stats)?

-- 
Paul Fulghum
Microgate Systems, Ltd

