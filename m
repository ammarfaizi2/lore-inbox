Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWCLQAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWCLQAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWCLQAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:00:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:13717 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751217AbWCLQAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:00:13 -0500
Date: Sun, 12 Mar 2006 17:00:06 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 5/8] hrtimer remove state field
In-Reply-To: <1142178108.19916.475.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603121650230.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain> 
 <20060312080332.274315000@localhost.localdomain>  <Pine.LNX.4.64.0603121302590.16802@scrub.home>
  <1142169010.19916.397.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0603121422180.16802@scrub.home>  <1142170505.19916.402.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121444530.16802@scrub.home>  <1142172917.19916.421.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121523320.16802@scrub.home>  <1142175286.19916.459.camel@localhost.localdomain>
  <Pine.LNX.4.64.0603121608440.17704@scrub.home> <1142178108.19916.475.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 12 Mar 2006, Thomas Gleixner wrote:

> How do you want to prevent that a signal is dequeued on one CPU while
> the softirq expires the timer on another CPU ? This can not be
> prevented.

This should not be possible in first place, otherwise it's a bug.
The original problem was a broken state machine, is that so hard to 
believe? If there is another problem, please provide more details.

bye, Roman
