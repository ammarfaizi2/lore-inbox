Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264777AbTCCMPC>; Mon, 3 Mar 2003 07:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbTCCMPC>; Mon, 3 Mar 2003 07:15:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17414 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264777AbTCCMPA>; Mon, 3 Mar 2003 07:15:00 -0500
Date: Mon, 3 Mar 2003 13:25:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030303122525.GB20929@atrey.karlin.mff.cuni.cz>
References: <20030228121725.B2241@in.ibm.com> <20030228130548.GA8498@atrey.karlin.mff.cuni.cz> <20030228190924.A3034@in.ibm.com> <20030228134406.GA14927@atrey.karlin.mff.cuni.cz> <20030228204831.A3223@in.ibm.com> <20030228151744.GB14927@atrey.karlin.mff.cuni.cz> <1046458775.1720.5.camel@laptop-linux.cunninghams> <20030303095824.A2312@in.ibm.com> <1046673408.27945.5.camel@laptop-linux.cunninghams> <20030303122453.A2634@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303122453.A2634@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Mon, 2003-03-03 at 17:28, Suparna Bhattacharya wrote:
> > > If you add to that the possibility of being able to save more 
> > > in less space if you have compression, would it be useful ?
> > 
> > I'm not sure that it would because we don't know how much compression
> > we're going to get ahead of time, so we don't know how many extra pages
> 
> The algorithm could be adjusted to deal with that, however ...
> 
> > we can save. The compression/decompression also takes extra time and
> > puts more drain on a potentially low battery.
> 
> .. I didn't think about the battery drain - valid point !

Actually I don't quiet think so. gzip compression is pretty cheap, and
if it makes you suspend faster and with less disk writes...

But I think it adds unneccessary complexity.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
