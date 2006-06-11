Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWFKSHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWFKSHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWFKSHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:07:47 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:57093 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750726AbWFKSHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:07:46 -0400
Message-ID: <448C5BF0.7070601@superbug.demon.co.uk>
Date: Sun, 11 Jun 2006 19:07:44 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060609)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Video drivers and System Management mode.
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I know we all laugh about the windows blue screen of death, but to be
fair, when Linux oops, it is not even able to display anything on the
screen, unless in dump terminal mode. I.e. Not X or some other GUI.

Are there any plans to implement a sort of interactive system management
mode, that would pop up a window when Linux oops. Something like the
program called SoftICE for windows would be a nice addition to Linux,
and help with kernel development.

For those who don't know what SoftICE does, when windows wishes to
display a blue screen of death (BSOD), SoftICE pops up a window showing
a disassembly of the point where the crash happened, and allows users to
type commands on the keyboard that will display extra information.
SoftICE also has a hot key, so the user can cause it to pop up at any
time they wish. During the pop-up, the entire OS is halted, and the only
commands possible are within the pop-up window. Another command exits
the pop-up and returns control to the OS.

I imagine that this feature would be tightly linked with the work
currently being done to unite all the different video drivers.
Unfortunately, I think work could take a long time. For example, on my
nvidia based card, even the kernel frame buffer drivers either fail to
display anything, or fail to scroll up the screen when a new printk happens.

I am not attending the KS this year, but I do hope that all the
interested parties can use a BOF session to come to some agreement on
the way forward, I would then be able to make useful contributions to at
least get my system working with whatever new model is decided on.

James
