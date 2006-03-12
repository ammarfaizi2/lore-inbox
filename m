Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWCLWeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWCLWeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWCLWeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:34:50 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:42115 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751167AbWCLWet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:34:49 -0500
From: Jiri Slaby <jirislaby@gmail.com>
To: Gaspar Bakos <gbakos@cfa.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 -- unable to open an initial console
In-reply-to: <Pine.SOL.4.58.0603121511350.22310@cfassp0.cfa.harvard.edu>
Message-Id: <E1FIZ9B-00089K-00@decibel.fi.muni.cz>
Date: Sun, 12 Mar 2006 23:34:45 +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@informatics.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaspar Bakos wrote:
>Hi,
>
>I am experimenting with the pristine 2.6.15.6 kernel on an AMD dual
>core CPU machine under FC3. The boot seems fine till i get to the
>point:
>
>Freeing unused memory ...
>"Warning: unable to open initial console".
>
>This is the last message, and then nothing ever happens. Maybe this
>message has nothing to do with the real error, but that is the last
>information I can grab.
>
>Everything works fine with previous kernel 2.6.13.4, except for
>occasional crashes under high load, which is the reason for the attempt
>to upgrade. I borrowed the old .config file from 2.6.13.4, and did
>"make oldconfig", so most of the settings must have remained the same.
>Then I also did a "make xconfig" just to have a better overview of what
>new options have appeared. The kernel compiled seemingly without any problems.
>
>By the way, when the old 2.6.13.4 kernel is booted up, there is no such
>warning about the console, and after the "Freeing unused memory" the
>next lines are:
>
>"Red HAT nash version 4.2.15 starting"
>...
>
>So maybe the problem is somewhere here.
Hi,

have you been googling? Initrd? Old udev? What about /dev/console before udev
starts?

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
