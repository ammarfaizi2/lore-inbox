Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992640AbWJTPAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992640AbWJTPAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992642AbWJTPAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:00:31 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:22436 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S2992640AbWJTPAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:00:30 -0400
Subject: Re: 2.6.18-rt6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <20061018083921.GA10993@elte.hu>
References: <20061018083921.GA10993@elte.hu>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 11:00:43 -0400
Message-Id: <1161356444.15860.327.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> i've released the 2.6.18-rt6 tree, which can be downloaded from the 
> usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/

This does not work here.  It boots but then wants to fsck my disks, and
dies with a sig 11 in fsck.ext3.  This is 100% reproducible and booting
2.6.18-rt5 works and does not want to fsck the disks. 

Sorry I don't have more information, the box is headless and in
production so I have limited debugging bandwidth.

Do you need my .config?

Lee

