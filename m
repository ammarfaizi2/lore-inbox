Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVJEPrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVJEPrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVJEPrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:47:33 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:60562
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030187AbVJEPrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:47:32 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, david singleton <dsingleton@mvista.com>
In-Reply-To: <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu>
	 <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
	 <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 05 Oct 2005 17:48:39 +0200
Message-Id: <1128527319.13057.139.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 10:29 -0400, Steven Rostedt wrote:
> Hmm, Ingo,
> 
> Do you know why time goes backwards when I run hackbench as a realtime
> process?  I added the output of start and stop and it does seem to go
> backwards.
> 
> Thomas?

Yes. Thats happening. I moved the priority of softirq-timer above
hackbench priority and the problem goes away. I look into this further.

tglx


