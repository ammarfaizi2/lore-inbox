Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbTA0VFC>; Mon, 27 Jan 2003 16:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTA0VFC>; Mon, 27 Jan 2003 16:05:02 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:49265
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267130AbTA0VFA>; Mon, 27 Jan 2003 16:05:00 -0500
Date: Mon, 27 Jan 2003 16:13:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mike Galbraith <efault@gmx.de>
cc: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59-mm6
In-Reply-To: <5.1.1.6.2.20030127210954.00c73468@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0301271608390.28617-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Mike Galbraith wrote:

> (well bugger, I _know_ I'm gonna regret this;)
> 
> When can the darn thing actually trigger an oops?

Depends, i have seen hardlocks where you don't get an oops, the nmi 
watchdog will work if the kernel is still running but say stuck in a busy 
loop and without the timer interrupt firing. Sometimes upping the interval 
by using idle=poll does help me out. Otherwise your cpu or kernel is 
really in a bad state.

	Zwane
-- 
function.linuxpower.ca

