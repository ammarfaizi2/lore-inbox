Return-Path: <linux-kernel-owner+w=401wt.eu-S932543AbXAQQ5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbXAQQ5T (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbXAQQ5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:57:18 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:45172 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543AbXAQQ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:57:17 -0500
Date: Wed, 17 Jan 2007 17:56:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lawrence MacIntyre <macintyrelp@ornl.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hung Port
In-Reply-To: <45AE46AA.7030700@ornl.gov>
Message-ID: <Pine.LNX.4.61.0701171756050.18562@yvahk01.tjqt.qr>
References: <45AE46AA.7030700@ornl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Last week I had a port (TCP:52557) that was mysteriously unavailable on
>my ubuntu machine (running kernel 2.6.15-27-k7 #1 SMP PREEMPT).  If you
>tried to bind to it, it was unavailable.  However, nmap (both to
>localhost and from an external host) reported the port closed.  fuser,
>lsof, and netstat had no record of the port being used.

Did your application forgot to set SO_REUSEADDR?

>  Our firewall
>logs didn't show any unusual traffic to the machine.  Nor did they show
>any traffic at all to/from that port on the machine.  After checking
>everything I could think of, I rebooted it, and there were no ports that
>were unavailable in this way when it came back up.  This morning another
>hung port has appeared (TCP:43355).  My best guess is that this is an
>ephemeral port that has somehow gotten hung in the kernel somewhere.
>Has anyone seen anything like this and/or is there anything else I could
>look at to figure it out?

	-`J'
-- 
