Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbTCZSEo>; Wed, 26 Mar 2003 13:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261848AbTCZSEo>; Wed, 26 Mar 2003 13:04:44 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57094 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261845AbTCZSEn>; Wed, 26 Mar 2003 13:04:43 -0500
Date: Wed, 26 Mar 2003 13:11:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ron House <house@usq.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: hdparm and removable IDE?
In-Reply-To: <1048689184.31839.7.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030326130640.8110B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Mar 2003, Alan Cox wrote:

> IDE hotswap at drive level is not supported by Linux. It might work ok. 
> Providing you shut the drive down fully and flush the cache before you
> unregister/unplug and replug before registering the new interface

There was a bunch of discussion of this, possibly on this list, and I
believe that the whole cable has to be unregistered or some such. I've
done it with only one drive on a cable, and it seemed to work. On the
other hand I was only playing.

I've seen some note regarding using ide-floppy for the whole drive instead
of the media, but I have never had the urge to try that.

WARNING: removable and hot swapable bays are not the same, had a client
prove that to herself the hard way.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

