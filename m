Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318019AbSFSVgQ>; Wed, 19 Jun 2002 17:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSFSVgP>; Wed, 19 Jun 2002 17:36:15 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:44029 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S318019AbSFSVgO>; Wed, 19 Jun 2002 17:36:14 -0400
Message-Id: <200206192133.g5JLXH814796@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Date: Wed, 19 Jun 2002 23:36:20 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020619205136.GA18903@suse.de>
In-Reply-To: <20020619205136.GA18903@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 22:51, Dave Jones wrote:
> Lots of bits got thrown out this time, as Christoph Hellwig went through
> the patch and picked up on quite a few obviously wrong bits. In addition,
> this patch introduces the mad axemen, who come to carve up all that is
> monolithic. Patrick's MTRR split-up has been around for a while, and could
> use a bit more testing before it goes to Linus. The AGPGART changes I did
> this afternoon, and haven't seen much testing at all yet.
>
> Finally, another round of compile fixes and the likes from Linux Kernel.
>

Ok I can run -dj2, but I cannot use X 8-( although this time no BUG or panic.

I got these errors during boot:
Jun 19 23:22:10 gandalf kdm[269]: IO Error in XOpenDisplay
Jun 19 23:22:10 gandalf kdm[259]: Server for display :0 terminated 
unexpectedly Jun 19 23:22:10 gandalf kdm[259]: Display :0 cannot be opened
Jun 19 23:22:13 gandalf kdm[284]: IO Error in XOpenDisplay
Jun 19 23:22:13 gandalf kdm[259]: Server for display :0 terminated 
unexpectedly Jun 19 23:22:13 gandalf kdm[259]: Display :0 cannot be opened
Jun 19 23:22:17 gandalf kdm[291]: IO Error in XOpenDisplay
Jun 19 23:22:17 gandalf kdm[259]: Server for display :0 terminated 
unexpectedly Jun 19 23:22:17 gandalf kdm[259]: Display :0 cannot be opened
Jun 19 23:22:20 gandalf kdm[298]: IO Error in XOpenDisplay
Jun 19 23:22:20 gandalf kdm[259]: Server for display :0 terminated 
unexpectedly Jun 19 23:22:20 gandalf kdm[259]: Display :0 cannot be opened
Jun 19 23:22:20 gandalf kdm[259]: Display :0 is being disabled (restarting 
too fast)

and whem starting X with startx:
<X startup messages>
XIO:  Fatal IO error 104 (connection reset by peer) on X server ":0.0"
      after 0 requests (0 known processed) with 0 events remaining.

when X is starting I see the normal 'flash' as the screen resolution is 
adjusted but the screen remains black and then the console returns.

same box (SIS and MGA)

	Rudmer
