Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVFJVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFJVGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFJVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:06:31 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27797 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261225AbVFJVGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:06:22 -0400
Subject: RE: ipw2100: firmware problem
From: Lee Revell <rlrevell@joe-job.com>
To: abonilla@linuxwireless.org
Cc: "'Netdev list'" <netdev@oss.sgi.com>,
       "'kernel list'" <linux-kernel@vger.kernel.org>
In-Reply-To: <003001c56dff$662fe4b0$600cc60a@amer.sykes.com>
References: <003001c56dff$662fe4b0$600cc60a@amer.sykes.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 17:07:18 -0400
Message-Id: <1118437639.6423.65.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 15:00 -0600, Alejandro Bonilla wrote:
> > > It thing of Mute in ALSA is stupid. If you want Sound, you
> > install the Sound
> > > and enable it. Why would it make you google for more things
> > to do? ALSA mute
> > > on install is WAY way, not OK.
> >
> > It took you 10 minutes of googling before you thought to try
> > the mixer?
> > Sorry dude, this is PEBKAC.
> >
> > Lee
> 
> Riiiight. It could be. Or it could be that no where in the world I have seen
> something where the device would be disabled by default without notifying
> the user. Why would you Mute the driver? Is the driver that bad, that the
> developers would rather Mute the sound card, just in case if the sound cards
> starts making noises and shit when the driver is loaded?
> 

Userspace should handle it, doing this in the kernel is bloat.

My Debian system initializes the mixer settings to a sane state just
fine when the alsasound init script is run.  Maybe you need a better
distro.

Users who compile ALSA from source are expected to know what they are
doing.  And, if you watch the "make install" output, it prints a big fat
warning that all mixer controls are muted by default.

> You are moving to another topic. Let's drop it.

Agreed, but it was your OT rant that changed the topic...

Lee

