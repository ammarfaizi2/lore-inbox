Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWBPRp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWBPRp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBPRp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:45:59 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:37125 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751390AbWBPRp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:45:58 -0500
Date: Thu, 16 Feb 2006 18:45:57 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Jens Axboe <axboe@suse.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmatthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060216174557.GC62333@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, Jens Axboe <axboe@suse.de>,
	Albert Cahalan <acahalan@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rmatthias.andree@gmx.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <Pine.LNX.4.61.0601262139290.27891@yvahk01.tjqt.qr> <20060127080026.GR4311@suse.de> <43DE98B9.6010008@tmr.com> <74B203F5-441F-4953-A95D-FEA162700876@mac.com> <43F4A632.8000500@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F4A632.8000500@tmr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 11:20:02AM -0500, Bill Davidsen wrote:
> I was really talking about something stable. HAL is an application, and 
> as such has to be changed avery time some developer has a bad dream and 
> changes the interface, moves a comtrol or report from /proc to /sys, or 
> otherwise requires a new way of interpreting the data. If you will, HAL 
> *in* the kernel where it must work.

Sorry, the era of stability is over.  Anything older than a year and
half or so is obsolete and should be upgraded.  To their honor Linus,
Andrew and a small minority of others tried to keep stability as
important, but given that the vast majority of the other developpers
don't care they lost.

For the kernel that means syscalls are stable, but everything
filesystem isn't (proc and sysfs in particular) and change on a whim,
and also ioctls, especially on vonluntarily undocumented kernel
interfaces, are rather unstable.

  OG.

