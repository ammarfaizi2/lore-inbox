Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbUKYHDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUKYHDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUKYHDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:03:12 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16063 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263002AbUKYHAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:00:15 -0500
Subject: Re: Suspend 2 merge: 22/51: Suspend2 lowlevel code.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411241453230.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101296166.5805.279.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411240931470.7171@musoma.fsmlabs.com>
	 <1101331206.3895.40.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411241453230.7171@musoma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1101333392.3895.79.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:56:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 08:55, Zwane Mwaikambo wrote:
> On Thu, 25 Nov 2004, Nigel Cunningham wrote:
> 
> > That's roughly what we're doing now, apart from the offlining/onlining.
> > I had considered trying to take better advantage of SMP support (perhaps
> > run a decompression thread on one CPU and the writer on the other, eg),
> > so we might want to apply this just to the region immediately around the
> > atomic copy/restore. That makes me wonder, though, what the advantage is
> > to switching to using the hotplug functionality - is it x86 only, or
> > more cross platform? (If more cross platform, that might possibly be an
> > advantage over the current code).
> 
> It's cross platform and removes the requirement for patches like;
> 
> Subject: Suspend 2 merge: 13/51: Disable highmem tlb flush for copyback.

Good point. I didn't see that.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

