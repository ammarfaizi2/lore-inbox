Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUJASxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUJASxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUJASxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:53:14 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:63662 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266143AbUJASxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:53:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Date: Fri, 1 Oct 2004 20:55:29 +0200
User-Agent: KMail/1.6.2
Cc: Kevin Fenzi <kevin-linux-kernel@scrye.com>
References: <415C2633.3050802@0Bits.COM> <20041001102351.GC18786@elf.ucw.cz> <20041001160333.1D229774C3@voldemort.scrye.com>
In-Reply-To: <20041001160333.1D229774C3@voldemort.scrye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410012055.29406.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 of October 2004 18:03, Kevin Fenzi wrote:
> >>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
> 
> Pavel> Hi!
> >> Anyone noticed that pmdisk software suspend stopped working in -rc3
> >> ?  In -rc2 it worked just fine. My script was
> >>
> >> chvt 1 echo -n shutdown >/sys/power/disk echo -n disk
> >> >/sys/power/state chvt 7
> >>
> >> In -rc3 it appears to write pages out to disk, but never shuts down
> >> the machine. Is there something else i need to do or am missing ?
> 
> Pavel> You are not missing anything, it is somehow broken. I'll try to
> Pavel> find out what went wrong and fix it. In the meantime, look at
> Pavel> -mm series, it works there.  Pavel
> 
> I finally had a chance to try 2.6.9-rc3 here last night.
> 
> It suspended ok for me, but on resume it would load in the cache and
> then reboot. :(

Always?  I mean, is it reproducible?  I have a similar problem, but it is not 
reproducible, apparently.  Sometimes it reboots, sometimes it reports a 
double fault, but most often it resumes just fine.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
