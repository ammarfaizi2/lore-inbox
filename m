Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVJQWBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVJQWBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVJQWBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:01:43 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:45205
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751352AbVJQWBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:01:42 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <Pine.LNX.4.10.10510171417220.24518-101000@godzilla.mvista.com>
References: <Pine.LNX.4.10.10510171417220.24518-101000@godzilla.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 18 Oct 2005 00:03:59 +0200
Message-Id: <1129586639.19559.152.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 14:43 -0700, Daniel Walker wrote:
> I found this latency ~5 minutes after boot up, no load . It looks like
> vgacon_scroll() has a memset like operation which can grow. 

5 minutes after bootup could also be related to a jiffies wrap problem. 

	tglx

