Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRHGWcY>; Tue, 7 Aug 2001 18:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269178AbRHGWcO>; Tue, 7 Aug 2001 18:32:14 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:6921 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269518AbRHGWcG>; Tue, 7 Aug 2001 18:32:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Mark Atwood <mra@pobox.com>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
Date: Wed, 8 Aug 2001 00:33:45 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.33.0108071925040.27407-100000@infradead.org> <m3g0b3v8zq.fsf@flash.localdomain>
In-Reply-To: <m3g0b3v8zq.fsf@flash.localdomain>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15UFO2-0nphWSC@fmrl03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 23:46, Mark Atwood wrote:
> Userspace init scripts point the finger at kernel, saying "there is no
> good and no well documented mapping method". Kernel points its finger
> at userspace, saying "this is the way we do it" and "we cant guarantee
> a perfect 100% mapping solution, so we're not even going to try for
> 90%" and "futz with your drivers and modules.conf and init scripts
> till you get something that works".

I'm working on one a possible solution, the Device Registry 
(www.tjansen.de/devreg). It solves this problem by assigning device ids to 
physical devices. This allows you to identify a physical device, even after 
you changed tge port.

Device ids can be used in two ways:
1. user space apps can use the device id to find the device's node in /dev
2. a user-space daemon can use the device ids to create stable symlinks to 
the /dev nodes (this is not possible to ethernet ids though)

bye...


