Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271121AbTG1Umu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271104AbTG1Uil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:38:41 -0400
Received: from luli.rootdir.de ([213.133.108.222]:34255 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S271065AbTG1Ufa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:35:30 -0400
Date: Mon, 28 Jul 2003 22:35:23 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 has i8042 mux problems
Message-ID: <20030728203523.GA857@rootdir.de>
References: <20030728052614.GA5022@rootdir.de> <20030728113626.GA1706@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728113626.GA1706@win.tue.nl>
Reply-By: Don Jul 31 22:32:02 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test1-ac3 i686
X-No-archive: yes
X-Uptime: 22:32:02 up 1 min,  2 users,  load average: 0.84, 0.25, 0.09
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting. Yes, the new keyboard driver knows far too much about
> keyboards, and that knowledge is right only in 98% of the cases.
> No doubt we'll be forced to back out a lot of probing done now.
> 
> Nevertheless it would be interesting to see precisely what happens.
> Could you try to change the #undef DEBUG in drivers/input/serio/i8042.c
> into #define DEBUG and report what output you get at boot time?

This is the only debug message i can see without keyboard.

serio: i8042 AUX Port at 0x60,0x64 irq 12
input: AT set2 keyboard on isa0060/serio0
serio i8042 KBD port at 0x60,0x64 irq 1

Can you tell me how to force the driver to enable my keyboard anyways?
It would be great, because booting is a pain right now.

Regards, claas
