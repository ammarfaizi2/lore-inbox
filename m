Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266443AbUG0Plx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUG0Plx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266381AbUG0Plx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:41:53 -0400
Received: from holomorphy.com ([207.189.100.168]:13956 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266449AbUG0Ph5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:37:57 -0400
Date: Tue, 27 Jul 2004 08:32:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Joel.Becker@oracle.com, Tim Connors <tconnors+linuxkml@astro.swin.edu.au>,
       Con Kolivas <kernel@kolivas.org>,
       Clemens Schwaighofer <cs@tequila.co.jp>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Autotune swappiness01
Message-ID: <20040727153229.GC2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joel.Becker@oracle.com,
	Tim Connors <tconnors+linuxkml@astro.swin.edu.au>,
	Con Kolivas <kernel@kolivas.org>,
	Clemens Schwaighofer <cs@tequila.co.jp>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040726202946.GD26075@ca-server1.us.oracle.com> <20040726134258.37531648.akpm@osdl.org> <cone.1090882721.156452.20693.502@pc.kolivas.org> <4105A761.9090905@tequila.co.jp> <20040726180943.4c871e4f.akpm@osdl.org> <4105AD1C.2050507@tequila.co.jp> <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au> <cone.1090896213.276247.20693.502@pc.kolivas.org> <Pine.LNX.4.53.0407271250210.23847@tellurium.ssi.swin.edu.au> <20040727034739.GA2161@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727034739.GA2161@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 08:47:39PM -0700, Joel Becker wrote:
> 	I happen to be a person who rolls his eyes at everyone's mention
> of micro-optimized "feel".  I've found that any system faster than
> 300MHz is pretty decent for normal desktop work (that is, moz + lots of
> terminals in gnome/kde).  Yes, I'm a luddite, I used to wait 45 seconds
> for moz to start in the morning on the 300Mhz.  I survived.
> 	In general, I can't notice the difference between 2.6.anything
> on my 1GHz.  Maybe everyone else can, but I can't.
> 	HOWEVER, the swappiness of '60' puts my system into
> fits-and-starts mode.  Not "It feels slower", but "It pauses for seconds
> at a time."  So I chimed in on this.
> 	And yes, I'd give up oodles of pagecache to avoid fits and
> starts.  But there's got to be a way to use the pagecache and not hang
> for seconds at a time.

I've had similar experiences except for the pauses. Could you identify
this as idle time, iowait, or cpu time (user/kernel)?

Also, does this behavior change at all as the IO scheduler varies? And
could you describe the system, e.g. IO devices/etc.?


-- wli
