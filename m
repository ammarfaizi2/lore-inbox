Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTCCKgl>; Mon, 3 Mar 2003 05:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTCCKgl>; Mon, 3 Mar 2003 05:36:41 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:64662 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S263215AbTCCKgj>; Mon, 3 Mar 2003 05:36:39 -0500
Date: Mon, 03 Mar 2003 23:49:57 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software Suspend Functionality in 2.5
In-reply-to: <20030303122453.A2634@in.ibm.com>
To: suparna@in.ibm.com
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046688385.1702.3.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1046369790.2190.9.camel@laptop-linux.cunninghams>
 <20030228121725.B2241@in.ibm.com>
 <20030228130548.GA8498@atrey.karlin.mff.cuni.cz>
 <20030228190924.A3034@in.ibm.com>
 <20030228134406.GA14927@atrey.karlin.mff.cuni.cz>
 <20030228204831.A3223@in.ibm.com>
 <20030228151744.GB14927@atrey.karlin.mff.cuni.cz>
 <1046458775.1720.5.camel@laptop-linux.cunninghams>
 <20030303095824.A2312@in.ibm.com>
 <1046673408.27945.5.camel@laptop-linux.cunninghams>
 <20030303122453.A2634@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 19:54, Suparna Bhattacharya wrote:
> On Mon, Mar 03, 2003 at 07:36:49PM +1300, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2003-03-03 at 17:28, Suparna Bhattacharya wrote:
> > > If you add to that the possibility of being able to save more 
> > > in less space if you have compression, would it be useful ?
> > 
> > I'm not sure that it would because we don't know how much compression
> > we're going to get ahead of time, so we don't know how many extra pages
> 
> The algorithm could be adjusted to deal with that, however ...

Ah I see. You're thinking of compressing the pages as we eat memory? I
guess I need to look at LKCD more closely. I think it can wait until we
get the basics of the expanded functionality sorted.

> 
> > we can save. The compression/decompression also takes extra time and
> > puts more drain on a potentially low battery.
> 
> .. I didn't think about the battery drain - valid point !

Of course that can be overcome too. The user simply starts swsusp
earlier or turns off compression if necessary.

Thanks for the thought provoking :>

Regards,

Nigel

