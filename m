Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289673AbSAJUxL>; Thu, 10 Jan 2002 15:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289672AbSAJUxC>; Thu, 10 Jan 2002 15:53:02 -0500
Received: from quechua.inka.de ([212.227.14.2]:31778 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S289669AbSAJUwz>;
	Thu, 10 Jan 2002 15:52:55 -0500
From: Bernd Eckenfels <ecki-news2002-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C3DDEA9.E8FAB8DC@nortelnetworks.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16OmBx-0008K2-00@sites.inka.de>
Date: Thu, 10 Jan 2002 21:52:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C3DDEA9.E8FAB8DC@nortelnetworks.com> you wrote:
> Imagine taking an input, doing dsp-type calculations on it, and sending it back
> as output.  Now...imagine doing it in realtime with the output being fed back to
> a monitor speaker.  Think about what would happen if the output of the monitor
> speaker is 1/4 second behind the input at the mike.  Now do you see the
> problem?  A few ms of delay might be okay.

What kind of signal run time do you normally have in digital sound processing
equipment? AFAIK one can expect a feew frames with of delay (n x 13ms).

Just dont feed back the processed signal to the singers monitor box.

> If I'm trying to watch a DVD on my computer, and assuming my CPU is powerful
> enough to decode in realtime, then I want the DVD player to take
> priority--dropping frames just because I'm starting up netscape is not
> acceptable.

You do not start up netscape while you do realtime av processing in
professional environemnt.

Well, an easy fix is to have the LL patch and do not use swap. Then you only
need reliable/predictable hardware (which is not so easy to get for PC).

Greetings
Bernd

