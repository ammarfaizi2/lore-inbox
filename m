Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267295AbSKPROJ>; Sat, 16 Nov 2002 12:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbSKPROI>; Sat, 16 Nov 2002 12:14:08 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:19642 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S267295AbSKPROI>; Sat, 16 Nov 2002 12:14:08 -0500
Date: Sat, 16 Nov 2002 18:21:00 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: yodaiken@fsmlabs.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021116172100.GG1877@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	yodaiken@fsmlabs.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <3DD57A5F.87119CB4@digeo.com> <20021115225932.GC1877@tahoe.alcove-fr> <20021116092341.A30010@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021116092341.A30010@hq.fsmlabs.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 09:23:41AM -0700, yodaiken@fsmlabs.com wrote:

> > > Here is the kgdb stub's "send a byte" function:
[...]
> 
> > USB (with USB-to-serial adapter), network, ieee1394 would be 
> > acceptable replacements for me.
> 
> Have you ever looked at a USB or 1394 driver? 

As a matter of fact, I did.

> The nice thing about
> serial is that the software to make it work is trivial. A debugger that 
> relies on a 5000 line driver is quite suspect.

Agreed. But even a suspect debugger is preferable to no debugger at all.

Look, serial ports are becoming obsolete. We (not everybody but many
people) need kgdb.

The general oppinion seems to be that a mini network stack + a simple
network card driver is the easiest thing to implement (mostly because
already done). That's fine for me.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
