Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSGUS6T>; Sun, 21 Jul 2002 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSGUS6T>; Sun, 21 Jul 2002 14:58:19 -0400
Received: from hoochie.linux-support.net ([216.207.245.2]:58035 "EHLO
	hoochie.linux-support.net") by vger.kernel.org with ESMTP
	id <S312619AbSGUS6S>; Sun, 21 Jul 2002 14:58:18 -0400
Date: Sun, 21 Jul 2002 14:01:23 -0500 (CDT)
From: Mark Spencer <markster@linux-support.net>
To: Daniel Phillips <phillips@arcor.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Zaptel Pseudo TDM Bus
In-Reply-To: <E17W5VF-0003KL-00@starship>
Message-ID: <Pine.LNX.4.33.0207211359210.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A random question: is there any reason why Ogg isn't among the codecs?

It wasn't ready when I started.  Ogg, like mp3, is generally a very poor
choice of codec for telephony, and even for the storage of files, unless
its performance has improved greatly.

On a 900 Mhz Athlon, you can get *hundreds* of simultaneous full-duplex
GSM full-rate codecs running.  Certainly that's an unrealistic expectation
even for half-duplex ogg or mp3.  As for using ogg as an actual telephony
protocol, its frame size is (or at least was at the time I contacted the
author) much too long to be practical.  Frame sizes for VoIP should be
around 160 to 240 samples in general.

Mark

