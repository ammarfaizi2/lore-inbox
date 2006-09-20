Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWITSqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWITSqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWITSqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:46:10 -0400
Received: from www.osadl.org ([213.239.205.134]:13515 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932160AbWITSqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:46:09 -0400
Subject: Re: 2.6.18-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com,
       Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200609201436.47042.gene.heskett@verizon.net>
References: <20060920141907.GA30765@elte.hu>
	 <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920182553.GC1292@us.ibm.com>
	 <200609201436.47042.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 20:47:20 +0200
Message-Id: <1158778040.5724.1020.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 14:36 -0400, Gene Heskett wrote:
> That looks like the chorus of the song I saw when it crashed on boot, 
> pretty darned close to identical.

I can reproduce it. It happens when CONFIG_HIGH_RES_TIMERS is off.
Looking into it right now.

	tglx


