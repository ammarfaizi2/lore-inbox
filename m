Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTLWClB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTLWClA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:41:00 -0500
Received: from [24.35.117.106] ([24.35.117.106]:5260 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264473AbTLWCk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:40:56 -0500
Date: Mon, 22 Dec 2003 21:40:53 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: synaptics mouse jitter in 2.6.0
Message-ID: <Pine.LNX.4.58.0312222127530.18261@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running Fedora Core 1 updated on a Presario 12XL325 laptop.  For a 
long time during the 2.5 series I couldn't use the synaptics support.  As 
a result, I haven't tested this for some time.  I just compiled a fresh 
2.6.0 tree, included synaptics support and now I am getting mouse jitter.

The easiest way to see this is to open Mozilla and go to a page with a lot 
of text links such as a news site with links to a number of stories.  
With synaptics support compiled in I get side to side jitter when moving 
the mouse over a link.  It looks as if my finger has a nervous twitch in 
it.  Then, when I take my finger off the touchpad to click on the link, 
the mouse cursor jumps about an eighth of an inch in a random direction.  It 
is very annoying since the jump takes it off the link and I can't click on 
it.

Compiling synaptics support out gets me back to a stable mouse cursor.
