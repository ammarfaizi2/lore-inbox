Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbTCCMvB>; Mon, 3 Mar 2003 07:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTCCMvB>; Mon, 3 Mar 2003 07:51:01 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:25081 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262604AbTCCMvA>;
	Mon, 3 Mar 2003 07:51:00 -0500
Date: Mon, 3 Mar 2003 18:36:40 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030303183640.A3237@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030228130548.GA8498@atrey.karlin.mff.cuni.cz> <20030228190924.A3034@in.ibm.com> <20030228134406.GA14927@atrey.karlin.mff.cuni.cz> <20030228204831.A3223@in.ibm.com> <20030228151744.GB14927@atrey.karlin.mff.cuni.cz> <1046458775.1720.5.camel@laptop-linux.cunninghams> <20030303095824.A2312@in.ibm.com> <1046673408.27945.5.camel@laptop-linux.cunninghams> <20030303122453.A2634@in.ibm.com> <20030303122525.GB20929@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303122525.GB20929@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Mon, Mar 03, 2003 at 01:25:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 01:25:26PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > On Mon, 2003-03-03 at 17:28, Suparna Bhattacharya wrote:
> > > > If you add to that the possibility of being able to save more 
> > > > in less space if you have compression, would it be useful ?
> > > 
> > > I'm not sure that it would because we don't know how much compression
> > > we're going to get ahead of time, so we don't know how many extra pages
> > 
> > The algorithm could be adjusted to deal with that, however ...
> > 
> > > we can save. The compression/decompression also takes extra time and
> > > puts more drain on a potentially low battery.
> > 
> > .. I didn't think about the battery drain - valid point !
> 
> Actually I don't quiet think so. gzip compression is pretty cheap, and
> if it makes you suspend faster and with less disk writes...
> 
> But I think it adds unneccessary complexity.

If that's the only concern left, I guess its time for us to go 
back and complete what we have (we still have a few issues to
think over and concentrate on fixing), look at Nigel's patches 
more closely, and then come back and discuss the algo sometime 
later .. You could make up your mind about the actual complexity 
then (both for suspend and resume paths). 

>From what I can gather from this whole discussion, it seems 
worth at least a detailed look on our part. 

Thanks for the inputs and insights.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

