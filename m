Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286468AbSAIP4q>; Wed, 9 Jan 2002 10:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSAIP4g>; Wed, 9 Jan 2002 10:56:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5137 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286468AbSAIP4S>; Wed, 9 Jan 2002 10:56:18 -0500
Date: Wed, 9 Jan 2002 16:56:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Greg KH <greg@kroah.com>, felix-dietlibc@fefe.de,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109155608.GG21317@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020109042331.GB31644@codeblau.de> <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> How many programs are we talking about here?  And what should they do?
> >
> >Very good question that we should probably answer first (I'll follow up
> >to your other points in a separate message).
> >
> >Here's what I want to have in my initramfs:
> >        - /sbin/hotplug
> >        - /sbin/modprobe
> >        - modules.dep (needed for modprobe, but is a text file)
> >
> >What does everyone else need/want there?
> 
> It is planned to move partition discovery to userspace which would then 
> instruct the kernel of the positions of various partitions.

Hmm, and when you insert PCMCIA harddrive, what happens?

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
