Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313640AbSDHOug>; Mon, 8 Apr 2002 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313642AbSDHOuf>; Mon, 8 Apr 2002 10:50:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40709 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313640AbSDHOue>; Mon, 8 Apr 2002 10:50:34 -0400
Date: Mon, 8 Apr 2002 10:48:08 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Levon <movement@marcelothewonderpenguin.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Two fixes for 2.4.19-pre5-ac3
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.3.96.1020408104259.21476B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002, John Levon wrote:

> But what about the recent discussion on the removal of sys_call_table ?
> 
> (I believe it was along the lines of "it's ugly, prevent it ...", "ah,
> but it has real uses, so why can't it stay as deprecated/unadvised ?"
> "*no response*").
> 
> I'm a bit disappointed this has just gone in without any real discussion
> on the usefulness of this for certain circumstances :(

  Sure, removing that would break a lot of cracker software. Oh wait,
maybe that's a good thing...

  For legitimate use, if any, a compile-time optional system call could be
added requiring a capability to use, and programs which are currently
doing that (AFS?) can be converted to use another f/s interface. I have
seen a few mentions of software which DO use that capability, I'm not sure
I've seen one which can be done no other way. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

