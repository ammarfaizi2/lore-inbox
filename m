Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUG0Dtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUG0Dtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 23:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUG0Dtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 23:49:31 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:21636 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S266233AbUG0Dt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 23:49:29 -0400
Date: Mon, 26 Jul 2004 20:47:39 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
Cc: Con Kolivas <kernel@kolivas.org>, Clemens Schwaighofer <cs@tequila.co.jp>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Autotune swappiness01
Message-ID: <20040727034739.GA2161@ca-server1.us.oracle.com>
Mail-Followup-To: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>,
	Con Kolivas <kernel@kolivas.org>,
	Clemens Schwaighofer <cs@tequila.co.jp>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cone.1090802581.972906.20693.502@pc.kolivas.org> <20040726202946.GD26075@ca-server1.us.oracle.com> <20040726134258.37531648.akpm@osdl.org> <cone.1090882721.156452.20693.502@pc.kolivas.org> <4105A761.9090905@tequila.co.jp> <20040726180943.4c871e4f.akpm@osdl.org> <4105AD1C.2050507@tequila.co.jp> <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au> <cone.1090896213.276247.20693.502@pc.kolivas.org> <Pine.LNX.4.53.0407271250210.23847@tellurium.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0407271250210.23847@tellurium.ssi.swin.edu.au>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 01:02:32PM +1000, Tim Connors wrote:
> I am not trying to say anything bad about your work - I am trying to
> caution Andrew that not everyone cares so much that they lose 200 megs of
> pagecache. It doesn't affect everyone equally - I'm just trying to put the
> voice of those of us who care more about responsiveness than throughput,
> if I may borrow the argument from upthread.

	I happen to be a person who rolls his eyes at everyone's mention
of micro-optimized "feel".  I've found that any system faster than
300MHz is pretty decent for normal desktop work (that is, moz + lots of
terminals in gnome/kde).  Yes, I'm a luddite, I used to wait 45 seconds
for moz to start in the morning on the 300Mhz.  I survived.
	In general, I can't notice the difference between 2.6.anything
on my 1GHz.  Maybe everyone else can, but I can't.
	HOWEVER, the swappiness of '60' puts my system into
fits-and-starts mode.  Not "It feels slower", but "It pauses for seconds
at a time."  So I chimed in on this.
	And yes, I'd give up oodles of pagecache to avoid fits and
starts.  But there's got to be a way to use the pagecache and not hang
for seconds at a time.

Joel

-- 

"I don't want to achieve immortality through my work; I want to
 achieve immortality through not dying."
        - Woody Allen

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
