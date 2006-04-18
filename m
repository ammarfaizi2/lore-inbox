Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWDRMUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWDRMUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWDRMUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:20:53 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:734 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750850AbWDRMUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:20:53 -0400
Subject: Re: [RT] bad BUG_ON in rtmutex.c
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1145324887.17085.35.camel@localhost.localdomain>
References: <1145324887.17085.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 05:20:50 -0700
Message-Id: <1145362851.5447.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 21:48 -0400, Steven Rostedt wrote:
...
> 
> So the question now is: is this a real bug?

It seems like a possible scenario . So if the false BUG_ON() needlessly
kills a perfectly running system, then it must be a bug. It's the case
of the buggy BUG_ON ;) !

Daniel

