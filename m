Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbVJEOs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbVJEOs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVJEOsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:48:55 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26002
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965204AbVJEOsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:48:41 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Knecht <markknecht@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510050255410.20622@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
	 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0510050255410.20622@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 05 Oct 2005 16:50:01 +0200
Message-Id: <1128523801.13057.129.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 03:12 -0400, Steven Rostedt wrote:
> First, Please don't send to my kihontech.com account.  That's my email
> that my customers use and I would really like to keep the spam noise down
> an that account.  Thanks!

Sorry. Fixed

> 
> So looking at the patch you sent, are you saying that the leak was a false
> positive?

Right. The task->lock_count accounting was screwed.

tglx


