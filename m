Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUCCXhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUCCXhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:37:11 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:3203 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261264AbUCCXhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:37:00 -0500
Date: Wed, 3 Mar 2004 23:36:04 +0000
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk,
       paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303233603.GA18722@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@suse.cz>,
	Cpufreq mailing list <cpufreq@www.linux.org.uk>,
	kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk,
	paul.devriendt@amd.com
References: <20040303215435.GA467@elf.ucw.cz> <20040303222712.GA16874@redhat.com> <20040303223510.GE222@elf.ucw.cz> <20040303224841.GB16874@redhat.com> <20040303225405.GF222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303225405.GF222@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 11:54:05PM +0100, Pavel Machek wrote:
 > Hi!
 > 
 > >  > We could make that functionality depend on CONFIG_ACPI, and allow
 > >  > runtime selection only if its defined... But those two drivers are
 > >  > pretty different just now and acpi-dependend chunk is pretty big. (It
 > >  > does funny stuff like polling for AC plug removal if we are in
 > >  > high-power state  and battery would not handle that. Old driver simply
 > >  > refused to use high-power states on such machines.)
 > > 
 > > you're aware of Dominik/Bruno's work on the 'acpilib'[1] stuff in this
 > > area right ? We'll need that anyway for Powernow-k7 and maybe longhaul too
 > > and its senseless duplicating this code.
 > 
 > That [1] looks like promise of url, but I don't see that url.

Hmm, cpufreq mailing list archives are your best bet.
What I meant to add was..

[1] acpilib is a made up name I just came up with, I've no idea
    what the guys who wrote it are referring to it as.

		Dave

