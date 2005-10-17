Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVJQWFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVJQWFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVJQWFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:05:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45294 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP
	id S1751343AbVJQWFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:05:30 -0400
Date: Mon, 17 Oct 2005 15:05:22 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <1129586639.19559.152.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.10.10510171503520.24518-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Oct 2005, Thomas Gleixner wrote:

> On Mon, 2005-10-17 at 14:43 -0700, Daniel Walker wrote:
> > I found this latency ~5 minutes after boot up, no load . It looks like
> > vgacon_scroll() has a memset like operation which can grow. 
> 
> 5 minutes after bootup could also be related to a jiffies wrap problem. 
> 

I saw it multiple times , but this trace was the biggest .. It looks like
it might be related to CONFIG_PRINTK_IGNORE_LOGLEVEL .. I don't see how
jiffies could be related though .

Daniel

