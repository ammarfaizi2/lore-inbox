Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBLKzY>; Mon, 12 Feb 2001 05:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129332AbRBLKzO>; Mon, 12 Feb 2001 05:55:14 -0500
Received: from [212.71.97.147] ([212.71.97.147]:25100 "EHLO yak.nomad.ch")
	by vger.kernel.org with ESMTP id <S129055AbRBLKzJ>;
	Mon, 12 Feb 2001 05:55:09 -0500
Date: Mon, 12 Feb 2001 11:55:06 +0100 (CET)
From: Christian Stocker <chregu@nomad.ch>
To: <linux-kernel@vger.kernel.org>
Subject: console blanking and 2.4.1
Message-ID: <Pine.LNX.4.30.0102121153270.15033-100000@bimbo.nomad.ch>
Organization: Nomad Online Agents
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Since I installed Kernel 2.4.1 on our server, the monitor does not turn
itself off after some minutes off inactivity... The screen goes blank, but
the monitor stays turned on...

Until and including 2.4.0 it worked fine. Monitor shut down, as soon as
the screen (console) went blank. There's no X on the thing, so that should
not be the problem. And i used the same .config for 2.4.0 and
2.4.1. ACPI is turned off. APM on. but it makes no differences if i
use APM or not (in 2.4.0 and in 2.4.1)

Any Idea where the problem could be? It has to be somewhere in the kernel,
'cause i didn't change anything on the system elsewhere and it still works
with 2.4.0. But i have no idea where to look at in the sources...

i use SuSE 7.0 and it's a Cyrix 200 Mhz. I don't know what kind of bios,
but i can have a look, if that's important (i tried different settings
there in the APM settings, but nothing helped neither)

chregu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
