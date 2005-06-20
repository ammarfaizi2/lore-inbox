Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFTKdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFTKdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVFTKdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:33:24 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:174 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261152AbVFTKdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:33:14 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Mon, 20 Jun 2005 12:31:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>
Message-ID: <42B6B733.24349.B0B7F9@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0506201159060.3728@scrub.home>
References: <42B685E8.9359.14B98F19@rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=103988@20050620.103138Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2005 at 12:22, Roman Zippel wrote:

[...]
> This patch is really damned hard to read as it changes too many things at 
> once. Maybe it does some necessary cleanups, but they are hard see, as 
> they pretty much get lost in all the functional changes.
> I'm pretty close to suggest to reject this patch until it clearly 
> separates new functionality from cleanups. If the current system is broken 

Roman,

it seems you don't like the patch for some personal reasons, and now your are 
trying to find arguments against it. The best method to get the perfomance 
implications is trying it (the patched kernel).

> fix it first, if the current system is a mess clean it up first, but 
> don't mix these two steps, unless you want to introduce more broken mess.

If you introduce something new (higher resolution clock), you should start with 
something clean. Just hacking it in the first attempt, anf then making it 
beautiful in a second attempt is a waste of time IMHO.

Regards,
Ulrich

