Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWIKLCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIKLCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 07:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWIKLCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 07:02:22 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:60548 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750708AbWIKLCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 07:02:21 -0400
Date: Mon, 11 Sep 2006 13:01:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Travis H." <solinym@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: design of screen-locks for text-mode sessions
In-Reply-To: <d4f1333a0609110240n3904e5a9g4359c338004008ae@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0609111259000.14498@yvahk01.tjqt.qr>
References: <d4f1333a0609110240n3904e5a9g4359c338004008ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This may diverge away from kernelspace, and if so I'll take the discussion
> off-list with interested parties.  In the meantime, I was wondering what people
> thought about the best design for locking text-mode console sessions.  It's a
> checkbox on some regulatory compliance list, I think for the PCI specs (that's
> credit cards, not the bus) and I'm sort of surprised there isn't an
> easy-to-find
> package for this.

screen. Start it. Hit ^A^X. Does not support autolocking though.

> Am I correct in assuming that login execs the shell, as opposed to
> hanging around
> after authentication?

Login waits for its subprocess to terminate. However, not every 'system' 
uses login, e.g. ssh.


Jan Engelhardt
-- 
