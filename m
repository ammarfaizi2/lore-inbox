Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVB1HuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVB1HuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVB1HuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 02:50:20 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:64219 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261219AbVB1HuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 02:50:13 -0500
Date: Mon, 28 Feb 2005 09:50:12 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-ID: <20050228075012.GN25818@edu.joroinen.fi>
References: <20050226191142.6288b2ef.khali@linux-fr.org> <20050227131027.GM25818@edu.joroinen.fi> <20050227184837.2563a454.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050227184837.2563a454.khali@linux-fr.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 06:48:37PM +0100, Jean Delvare wrote:
> Hi Pasi,
> 
> > Do you know about driver for W83627THF watchdog? I'm using Supermicro
> > P8SCI motherboard, and I haven't found working driver for it..
> 
> Have you tried w83627hf_wdt? I took a quick look at the W83627HF and
> W83627THF datasheets and watchdog timer seems to work identically. Since
> the driver doesn't seem to identify the chip (it probably should, BTW),
> I'd expect it to work.
> 

Yes, I have tried it. It doesn't work. 

The machine reboots always after the watchdog timeout set in the BIOS. I've
tried with the example watchdog daemon from the watchdog.txt, and with the
Debian "watchdog" package.

When I enable the debug messages and logging in the Debian watchdog package,
I can see that the watchdog daemon gets stuck while trying to update the
/dev/watchdog.. so the driver hangs..

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
