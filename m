Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290823AbSBVBWK>; Thu, 21 Feb 2002 20:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290827AbSBVBWA>; Thu, 21 Feb 2002 20:22:00 -0500
Received: from ns.suse.de ([213.95.15.193]:38669 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290823AbSBVBVv>;
	Thu, 21 Feb 2002 20:21:51 -0500
Date: Fri, 22 Feb 2002 02:21:49 +0100
From: Dave Jones <davej@suse.de>
To: Benjamin Pharr <ben@benpharr.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020222022149.N5583@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Benjamin Pharr <ben@benpharr.com>, linux-kernel@vger.kernel.org,
	vojtech@suse.cz
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu>; from ben@benpharr.com on Thu, Feb 21, 2002 at 05:37:00PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > It compiled fine. When I booted up everything looked normal with the
 > exception of a 
 > eth1: going OOM 
 > message that kept scrolling down the screen. My eth1 is a natsemi card.

 That's interesting. Probably moreso for Manfred. I'll double check
 I didn't goof merging the oom-handling patch tomorrow.

 > Eventually that stopped and gdm came up. For some reason my keyboard and
 > mouse wouldn't work.

 -dj includes a different input layer to Linus' tree, which requires
 some extra options enabled.  Vojtech, this is quite a frequent
 'bug report', and I think if you merged that with Linus, the number
 of reports would climb. Is there a possibility of simplifying the
 config.in somewhat? Or at least changing the defaults to give the
 element of least surprise..
 
 > It got to check.c in fs/partitions before stopping with an error.

 That one I've not got an answer for. Can you give me more information
 about your disk layout, partitions, number of disks, scsi?/ide?/lvm?
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
