Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSCOLAD>; Fri, 15 Mar 2002 06:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOK7z>; Fri, 15 Mar 2002 05:59:55 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10882 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S289815AbSCOK7k>;
	Fri, 15 Mar 2002 05:59:40 -0500
Date: Thu, 14 Mar 2002 14:02:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020314140210.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com> <20020312172134.A5026@ucw.cz> <3C8E2C2C.2080202@evision-ventures.com> <20020312173301.C5026@ucw.cz> <3C8E3025.4070409@evision-ventures.com> <20020312175044.A5228@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020312175044.A5228@ucw.cz>; from vojtech@suse.cz on Tue, Mar 12, 2002 at 05:50:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> You may happen to have the numbers, though - that should be enough.
> 
> Btw, I have a CMD640B based PCI card lying around here, but never
> managed to get it generate any interrupts, though the rest seems to be
> working.

Attach it to the timer interrupt -- that should do it for testing. Simplest
way is to make ide timeouts HZ/100 and killing "lost interrupt" msg ;-).

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

