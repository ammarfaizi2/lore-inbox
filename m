Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262607AbTCIUX2>; Sun, 9 Mar 2003 15:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTCIUX2>; Sun, 9 Mar 2003 15:23:28 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47623 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262607AbTCIUX0>; Sun, 9 Mar 2003 15:23:26 -0500
Date: Sun, 9 Mar 2003 15:30:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andries.Brouwer@cwi.nl
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
In-Reply-To: <UTC200303090817.h298HF804486.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.3.96.1030309152451.9062C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> > So you are saying the same thing I am, are you not?
> 
> The problem was one about translation, not about capacity.

The *problem* was translation, the proposed *solution* was using the BIOS
values in preference to drive values would include capacity. Or I misread
the intent (or code).

I would think that the capacity should code from the drive, if the BIOS
geometry is clearly wrong from that capacity (no, I didn't define that)
then using it will/may cause problems in applications and perhaps the
kernel, although LBA should be used and geometry not an issue.

Feel free to read the original post otherwise, I thought using the BIOS
data was the intent, period.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

