Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270604AbUJUFCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270604AbUJUFCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270437AbUJUE6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:58:02 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:3547 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270513AbUJUEzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:55:47 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: miller@techsource.com
Content-Type: text/plain
Organization: 
Message-Id: <1098334097.9402.958.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Oct 2004 00:48:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller writes:

> (2) How much would you be willing to pay for it?
>
> (3) How do you feel about the choice of neglecting
> 3D performance as a priority?  How important is 3D
> performance?  In what cases is it not?
>
> (4) How much extra would you be willing to pay for
> excellent 3D performance?
>
> (5) What's most important to you, performance, price,
> or stability?

Stability with a kernel of my choice on possibly
non-x86 hardware matters most. Digital DVI, fanless
operation, and DVD scaling are next. After that, 3D.

I'm not so sure you have to give up 3D. You can put
at least 4 AltiVec-capable "G4" CPUs on a PCI board
without having horrible power and temperature issues.
(Perhaps an AGP board can safely support even more.)
Each will do 4 32-bit floating-point fused-multiply-add
operations per cycle. That's got to be good for something.
I think the latest chips have built-in memory interfaces.
They have RapidIO interfaces. So you make your FPGA
speak RapidIO protocol (easy) and have each CPU render
every fourth frame.

One could even put the X server on the card.

Ultimately, this is a huge risk, with potentially
great reward. One must take some risks to succeed,
and this one is a whopper.


