Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSGDSVw>; Thu, 4 Jul 2002 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSGDSVv>; Thu, 4 Jul 2002 14:21:51 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:48591 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S313190AbSGDSVu>; Thu, 4 Jul 2002 14:21:50 -0400
Date: Thu, 4 Jul 2002 14:30:10 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Xinwen - Fu <xinwenfu@cs.tamu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel timers vs network card interrupt
In-Reply-To: <Pine.SOL.4.10.10207041109300.12365-100000@dogbert>
Message-ID: <Pine.LNX.4.33.0207041428530.11127-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         In fact I want a timer (either in user level or kernel level).
> This timer (hope it is a periodic timer) must expire at the interval that
> I specify. For example, if I

this sounds *perfect* for /dev/rtc, assuming you can deal with 
its fixed set of periodic rates.

