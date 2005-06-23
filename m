Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVFWU2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVFWU2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbVFWUYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:24:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30690 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263046AbVFWUW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:22:26 -0400
Subject: Re: aic79xx -> can't  suspend
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
In-Reply-To: <20050623193224.GD2251@voodoo>
References: <1119549104.13259.1.camel@mindpipe>
	 <20050623193224.GD2251@voodoo>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 16:22:24 -0400
Message-Id: <1119558145.1609.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-23 at 15:32 -0400, Jim Crilly wrote: 
> On 06/23/05 01:51:43PM -0400, Lee Revell wrote:
> > I have a machine with an Adaptec 2940U2W adapter running 2.6.11.  When I
> > try to go into standby like so:
> > 
> >     echo standby > /sys/power/state
> > 
> > this is what happens:
> 
> AFAIK no SCSI drivers have had power management functions implemented, a
> quick grep for PM_ in drivers/scsi seems to confirm that only the PCMCIA
> SCSI drivers even look for PM events.

Hmm, actually, this is still pretty bad.  Shouldn't the suspend fail
with "power management not implemented for device aic9xxx?" rather than
crashing and burning?

Also, who is the aic9xxx maintainer?  I could not find any reference to
it at all in MAINTAINERS.

Finally, is there an authoritative, up to date driver developers guide
for the SCSI subsystem, like the one for ALSA?

TIA,

Lee





