Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUGAS7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUGAS7C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUGAS5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:57:38 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:19197 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266228AbUGAS4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:56:00 -0400
Date: Thu, 1 Jul 2004 11:55:55 -0700
From: John Sage <jsage@finchhaven.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Parentage of BPF code in Linux
Message-ID: <20040701185555.GH6445@sparky.finchhaven.net>
References: <20040701181002.GG6445@sparky.finchhaven.net> <20040701184354.GJ5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701184354.GJ5414@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt:

On Thu, Jul 01, 2004 at 01:43:55PM -0500, Matt Mackall wrote:
> Date: Thu, 1 Jul 2004 13:43:55 -0500
> From: Matt Mackall <mpm@selenic.com>
> To: John Sage <jsage@finchhaven.com>
> Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
> Subject: Re: Parentage of BPF code in Linux
> User-Agent: Mutt/1.3.28i
> 
> On Thu, Jul 01, 2004 at 11:10:02AM -0700, John Sage wrote:
> > [Non-subscriber: please cc on replies]
> > 
> > WRT to the SCO/IBM/Linux imbroglio, there was an interesting
> > assertion made on the Yahoo! Finance message board for SCOX, and I
> > wondered if anyone could shed some light.
> > 
> > The assertion is this:
> > 
> > "...among other things, the Berkeley Packet Filter code, which was
> > written by an independent developer for the Missouri School
> > District, licensed under the BSD license terms that never was part
> > of SysV at any time..."
> 
> There's a from-scratch reimplementation of BPF in Linux (called
> Linux Socket Filter) by Jay Schulist in net/core/filter.c. And he
> appears to have worked for the _Wisconsin_ school district at the
> time. A Google search on "schulist filter wisconsin" reveals:
> 
>   Jay Schulist, a senior software engineer with Pleasanton,
>   California's Bivio Networks says he wrote the 500 lines of code in
>   1997 as part of a volunteer project for the Stevens Point Area
>   Catholic Schools in Wisconsin. "I used it for helping a local
>   school district in my home town to connect their old Apple
>   Macintosh machines to the Internet," he said.

Interesting.

Thank you.

And there it is:

/*
 * Linux Socket Filter - Kernel level socket filtering
 *
 * Author:
 *     Jay Schulist <jschlst@samba.org>
 *
 * Based on the design of:
 *     - The Berkeley Packet Filter

/* snip */


The only other reference I've been able to find to this "Missouri
School District/BPF" meme was in a post to a ZDNet message board back
in November, 2003...


- John
-- 
10 print "Home"
20 print "Sweet"
30 goto 10
