Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbTEHAmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTEHAmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:42:01 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:18603 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264344AbTEHAmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:42:00 -0400
Date: Wed, 7 May 2003 20:25:30 -0400
From: Ben Collins <bcollins@debian.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: ieee1394 still broken, vesafb still broken, ipv6 still broken
Message-ID: <20030508002530.GF679@phunnypharm.org>
References: <20030507235104.GA12486@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507235104.GA12486@codeblau.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 01:51:04AM +0200, Felix von Leitner wrote:
> I am surprised that Linus thinks now is the time to move towards a
> stable 1.6 release, I don't see any sign for increased stability in
> 2.5.59.  I am still forced to use 2.5.53 because that is the last kernel
> that has working ieee1394.
> 
> To reiterate the problems:
> 
>   ohci1394 detects my controller, sbp2 gets the same unsolicited packets
>     from my Maxtor firewire hard disk as 2.5.53, but no sign of a
>     detected SCSI device.

Hey, maybe emailing the linux1394-devel list would help a bit with this
one.

I assume you mean 2.5.69 and not 2.5.59. Does it work in 2.5.54? If so,
did you diff 2.5.53 and 2.5.54 and see if you could pinpoint what caused
it to stop working?

Since this is the first I've heard of your report (just checked recent
linux1394-devel messages and I don't see your name), we'll have to start
from scratch on your problem. Since I have been using 2.5.x for a long
time with ohci1394 and sbp2, and I've heard no other reports of this
kind, I can honestly say that your report is not the norm. In fact,
current 2.4/2.5 is the most stable ieee1394 code there is.

Just to put it into perspective I currently have an i386 running 2.5.69
with ohci1394/sbp2 for burning DVD's, and my ultrasparc has a 200gig
LaCie drive attached to an S800 card that handles backups from all my
systems on a nightly basis. I haven't even seen the first notion of a
problem for quite some time (all the ones I did see are fixed).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
