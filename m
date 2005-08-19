Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVHSQ5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVHSQ5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVHSQ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:57:14 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.21]:21064 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932554AbVHSQ5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:57:13 -0400
Subject: Re: 2.6.13-rc6-rt9
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050818060126.GA13152@elte.hu>
References: <20050818060126.GA13152@elte.hu>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 18:56:14 +0200
Message-Id: <1124470574.17311.4.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Paul, others,

I'm trying to run a user-mode-linux guest under the RT kernel however
the uml process never gets out of the calibrate delay loop. It seems as
if the signal never gets through.

A non -rt host kernel does work (with a similar .config).

Could this be related to pauls task list changes?

Kind regards,

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

