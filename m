Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSGYPNn>; Thu, 25 Jul 2002 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSGYPNn>; Thu, 25 Jul 2002 11:13:43 -0400
Received: from sendar.prophecy.lu ([213.166.63.242]:59532 "EHLO
	sendar.prophecy.lu") by vger.kernel.org with ESMTP
	id <S316187AbSGYPNn>; Thu, 25 Jul 2002 11:13:43 -0400
Date: Thu, 25 Jul 2002 17:15:55 +0200 (CEST)
From: Emil Eifrem <emil@eifrem.com>
X-X-Sender: emil@sendar.prophecy.lu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Bill Rugolsky Jr." <rugolsky@telemetry-investments.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: FS corruption on Dell Inspiron 8k w/ IBM-DJSA-220
In-Reply-To: <1027602291.9885.61.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207251657550.27984-100000@sendar.prophecy.lu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 2002, Alan Cox wrote:
> Please replicate the problem from a boot where you have never loaded
> binary only drivers like NVdriver. That way we might actually be able to
> try and debug it.
> 
> So I'd say get rid of NVdriver for a bit, force an fsck to check the
> disk is clean then duplicate the corruption/crash and report it

I upgraded to the latest RH 7.3 kernel (as per Bill's suggestion), removed
all NVidia drivers, booted up in runlevel 1 and tried to reproduce the
problem. After a couple of hours of copying 1 gig files between
partitions, it hasn't crashed. This could be thanks to a bugfix that went
into 2.4.18-5 (as opposed to 2.4.18-3), but I wouldn't count on it.

The problems I've experienced so far (crashes, fs corruption, etc) have
been irregular at best and sometimes when I've made a supposed fix (such
as disabling DMA), ran some test scripts for several hours which passed
without a problem -- only to get a crash or corruption a week later.

Anyway, I'll let the laptop shuffle files overnight and drop you guys a 
report if it does crash.

-EE

