Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVCAVka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVCAVka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCAVka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:40:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:5058 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262072AbVCAVkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:40:22 -0500
Subject: Re: 2.6.11-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mws <mws@twisted-brains.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503011236.58222.mws@twisted-brains.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <200502251430.16860.mws@twisted-brains.org>
	 <1109379043.14993.93.camel@gaston>
	 <200503011236.58222.mws@twisted-brains.org>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 08:38:15 +1100
Message-Id: <1109713095.5679.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 12:36 +0100, Mws wrote:
> hi benjamin
> 
> now i had some spare time to do some investigation
> 
> booting the 2.6.11-rc5 with radeonfb.default_dynclk=0 or with -1
> brings up a framebuffer console. everything is fine.
> starting xorg-x11 with Ati binary only drivers just brings up a black screen
> without a mouse cursor and freezes the hole machine. even network ect. 
> is no more reachable from outside the machine. worst thing out of that
> a tail on the log files (on another machine) does immediately stop - also no 
> output is written to syslog :/
> 
> next scenario - test 2.6.11-rc5 with radeonfb.default_dynclock=0 and -1
> starting xorg-x11 with Xorg Radeon driver. 
> a grey screen comes up - mouse cursor is visible and also able to move for
> 5 - 8 seconds after screen display - then freezes the whole machine again.

Ok, so it's not dynamic clocks. At this point, i have no idea what's
going on. I don't yet have any access to PCI Express hardware. You
should report this to X.org list where others can try to help me track
this down.

Ben.


