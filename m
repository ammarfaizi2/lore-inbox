Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVLERQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVLERQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVLERQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:16:59 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:52366 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751344AbVLERQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:16:58 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Mark Lord <lkml@rtr.ca>, Rob Landley <rob@landley.net>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051205164418.GA12725@merlin.emma.line.org>
References: <20051203135608.GJ31395@stusta.de>
	 <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
	 <200512042131.13015.rob@landley.net> <4394681B.20608@rtr.ca>
	 <1133800090.21641.17.camel@mindpipe>
	 <20051205164418.GA12725@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 12:17:28 -0500
Message-Id: <1133803048.21641.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 17:44 +0100, Matthias Andree wrote:
> This constant shifting the blame on someone else is becoming
> offensive.
> 
> Diligent maintainers put "INCOMPATIBLE CHANGES" sections up front in
> their release announcements or notes, that is the upstream
> maintainer's chance to state "wpa_supplicant version >= 1.2.3
> required" and really pass the buck on to the distros. Without such
> upgrade-required-for: notes, it's just rude. "We break everything but
> you need to find out for
> yourself which..."
> 

I'm not trying to shift blame, I am just saying that with their access
to a larger hardware and user base the distros are in a much better
position to regression test changes than the kernel developers.

And I didn't even mention the cases where the distros just don't do
their homework.  For example in order to insulate users from internal
changes ALSA has a kernel and userspace (alsa-lib) component and both
must be upgraded in sync to properly support new hardware.  This is
common knowledge.  But many distros keep shipping kernel upgrades that
introduce new ALSA drivers but don't bother to make the kernel upgrade
depend on an alsa-lib upgrade, or even to make a newer alsa-lib
available.

Lee

