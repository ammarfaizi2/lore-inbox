Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVB0S15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVB0S15 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVB0S15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 13:27:57 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:40375 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261465AbVB0S1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 13:27:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp logic error?
Date: Sun, 27 Feb 2005 19:27:39 +0100
User-Agent: KMail/1.7.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050227174309.GA27265@piper.madduck.net> <20050227175039.GL1441@elf.ucw.cz>
In-Reply-To: <20050227175039.GL1441@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502271927.39982.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 27 of February 2005 18:50, Pavel Machek wrote:
> Hi!
> 
> > > Ugh, too late, I already forgot what went wrong for you. Anyway
> > > try reading Documentation/power/swsusp.txt and/or going to
> > > 2.6.11-rc4. If that does not help, debug with printk :-).
> > 
> > I already did the first two. I will try 2.6.11-rc4 now.
> > 
> > Please check my first post, if you have the time:
> > 
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=110789536921510&w=2
> 
> Ok, this one.
> 
> I do not know what is going wrong. swsusp seems to work for
> people... or at least it works for me. Here's my .config, perhaps you
> have something unusual?
> 
> I do have CONFIG_PM_STD_PARTITION="/dev/hda1", perhaps that's
> neccessary?

I don't set CONFIG_PM_STD_PARTITION, but I pass the "resume" parameter
to the kernel and it works (no fuss, on x86-64 and i386).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
