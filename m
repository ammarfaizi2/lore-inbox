Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274756AbRJFAWN>; Fri, 5 Oct 2001 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274757AbRJFAWE>; Fri, 5 Oct 2001 20:22:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274756AbRJFAVr>; Fri, 5 Oct 2001 20:21:47 -0400
Subject: Re: Thinkpad 755CX & 2.4: Machine Check Exception
To: chris@chiappa.net
Date: Sat, 6 Oct 2001 01:27:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011005195939.A7662@lumberjack.snurgle.org> from "Chris Chiappa" at Oct 05, 2001 07:59:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pfJQ-0008Br-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got a Thinkpad 755CX (75MHz Pentium classic with the f00f bug).  I've
> been unable to boot any 2.4 kernels, even though 2.2 seems to run fine, and
> burnP5 doesn't seem to produce any ill effects.

2.4.10acX should be fine. The problem is that many pentium class boxes the
vendors didnt correctly wire the mce handling. The 2.4.10-ac tree defaults
to mce off for P5 boxes. (Or boot with "nomce" for older 2.4)
