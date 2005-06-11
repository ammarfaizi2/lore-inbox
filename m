Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVFKXue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVFKXue (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 19:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFKXue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 19:50:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5370 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261853AbVFKXua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 19:50:30 -0400
Date: Sat, 11 Jun 2005 16:50:14 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       <linux-kernel@vger.kernel.org>, <sdietrich@mvista.com>
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <1118533485.13312.91.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.44.0506111649380.29241-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Thomas Gleixner wrote:

> On Sat, 2005-06-11 at 13:51 -0700, Daniel Walker wrote:
> > On Sat, 11 Jun 2005, Ingo Molnar wrote:
> 
> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> > not sure if there is any function call overhead .. So the soft replacment 
> > of cli/sti is 70% faster on a per instruction level .. So it's at least 
> > not any slower .. Does everyone agree on that?
> 
> No, because x86 is not the whole universe

It's only implemented on x86 . 

Daniel

