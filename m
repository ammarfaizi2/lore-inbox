Return-Path: <linux-kernel-owner+w=401wt.eu-S1751604AbXAUOEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXAUOEZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbXAUOEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 09:04:25 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:45186 "EHLO
	allen.werkleitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbXAUOEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 09:04:24 -0500
Date: Sun, 21 Jan 2007 15:04:21 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Theodore Tso <tytso@mit.edu>, Joe Barr <joe@pjprimer.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20070121140421.GA13425@linuxtv.org>
References: <1169242654.20402.154.camel@warthawg-desktop> <20070120173644.GY24090@1wt.eu> <20070121055456.GC27422@thunk.org> <20070121070557.GB31780@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070121070557.GB31780@1wt.eu>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 87.162.108.192
Subject: Re: Serial port blues
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 08:05:57AM +0100, Willy Tarreau wrote:
> On Sun, Jan 21, 2007 at 12:54:56AM -0500, Theodore Tso wrote:
> > On Sat, Jan 20, 2007 at 06:36:44PM +0100, Willy Tarreau wrote:
> > 
> > > Now he must be careful about avoiding busy loops in the rest of the
> > > program, or he will have to use the reset button.
> > 
> > An easy way of dealing with this is to have an sshd running
> > an alternative port running at a nice high priority (say, prio 95 or
> > so).  That way, if you screw up, you can always login remotely and
> > kill the offending program.
> >
> > There is also a RT Watchdog program which can be found on
> > rt.wiki.kernel.org which can be used to recover from runaway real-time
> > processes without needing to hit the reset button.
> 
> Thanks for those hints, I've been used to play with the reset button,
> at least it has forced me to double check my code before running it :-)

I think SysRq-N sets all processes with RT-priority to non-RT.


Johannes
