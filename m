Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUAJROz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUAJROz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:14:55 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:1473 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S265266AbUAJROy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:14:54 -0500
From: lkml@nitwit.de
To: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: The hardware reports a non fatal, correctable incident occured on CPU 0.
Date: Sat, 10 Jan 2004 18:16:22 +0100
User-Agent: KMail/1.5.4
References: <200401091748.10859.lkml@nitwit.de> <200401091712.02802.eric@cisu.net>
In-Reply-To: <200401091712.02802.eric@cisu.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101816.22612.lkml@nitwit.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 00:12, Eric wrote:
> 	Check your hardware CPU/MOBO/RAM. Overheating? Bad Ram? Cheap mobo?
> MCE should not be triggered under any circumstances unless it is a kernel
> bug(RARE, I believe the MCE code is simple) or you REALLY have a hardware
> problem. As said before, the bios is resetting your fsb to 100 as a
> fail-safe because something bad happened.

Well, my system did run very stable and in the meantime again does run very 
stable on both, 2.4.21 and Windows XP...

> 	BTW, check your setup, an AMD 2200+ should run at 1.8ghz i believe. If you

Yes.

> > What the fuck is going on here?? As far as I figured out this has
> > something to do with MCE (CONFIG_X86_MCE=y, CONFIG_X86_MCE_NONFATAL=y)
> > (?).
>
> 	Leave it enabled, its a good thing to tell you when you have bad hardware.
> Its not a kernel problem, but a feature.

Well, it is a good thing to tell me, but it's not a good thing to make my 
system auto-reset itself before reaching the BIOS afterwards...

timo

