Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVA2X4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVA2X4h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVA2X4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:56:37 -0500
Received: from zork.zork.net ([64.81.246.102]:52710 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261612AbVA2X40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:56:26 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm2
References: <20050129131134.75dacb41.akpm@osdl.org>
	<6u3bwj7rwo.fsf@zork.zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Sat, 29 Jan 2005 23:56:23 +0000
In-Reply-To: <6u3bwj7rwo.fsf@zork.zork.net> (Sean Neakums's message of "Sat,
	29 Jan 2005 23:10:47 +0000")
Message-ID: <6uy8eb6b88.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> On a PowerBook (PowerBook5.4), when snd_powermac is modprobed during
> the boot, I get the following.  After similar messages for a few more
> modules, the machine seems wedged.

Brice Goglin's patch fixes this.

However, when I modprobe radeonfb I get:

Jan 29 23:38:16 briny kernel: PCI: Unable to reserve mem region #1:8000000@b8000000 for device 0000:00:10.0
Jan 29 23:38:16 briny kernel: radeonfb: probe of 0000:00:10.0 failed with error -16

Not sure if this is expected or not on this platform.

With radeonfb built-in (my current working configuration with 2.6.9)
the screen clears and the machine seems to hang early in the boot.
