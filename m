Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUAKK2C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 05:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbUAKK2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 05:28:02 -0500
Received: from AGrenoble-101-1-1-238.w193-251.abo.wanadoo.fr ([193.251.23.238]:60811
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S265785AbUAKK1w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 05:27:52 -0500
Subject: Re: Laptops & CPU frequency
From: Xavier Bestel <xavier.bestel@free.fr>
To: Robert Love <rml@ximian.com>
Cc: jlnance@unity.ncsu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073791061.1663.77.camel@localhost>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073816858.6189.186.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 11:27:39 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim 11/01/2004 à 04:17, Robert Love a écrit :
> On Sat, 2004-01-10 at 21:56, jlnance@unity.ncsu.edu wrote:
> 
> >     The frequency displayed in /proc/cpuinfo does not change if the AC
> > adapter is toggled on or off after the machine has booted.  It stays
> > in the same mode as it was booted into.  I am curious if this is because
> > the CPU frequency really is not changing, or if it is because the
> > number in /proc/cpuinfo is only calculated at boot.
> 
> The MHz value in /proc/cpuinfo should be updated as the CPU speed
> changes - that is, it is not calculated just at boot, but it is updated
> as the speed actually changes.

2.6.0 doesn't do that on my laptop. Moreover, if I ever boot on battery,
when switching to AC power, lots of things fail (mouse is jerky, pcmcia
doesn't work ...)

	Xav

