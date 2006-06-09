Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWFITJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWFITJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWFITJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:09:16 -0400
Received: from www.osadl.org ([213.239.205.134]:53897 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030413AbWFITJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:09:15 -0400
Subject: Re: 2.6.17-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mike Galbraith <efault@gmx.de>
Cc: Daniel Walker <dwalker@mvista.com>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149878466.7907.5.camel@Homer.TheSimpsons.net>
References: <20060607211455.GA6132@elte.hu>
	 <1149842550.7585.27.camel@Homer.TheSimpsons.net>
	 <1149847951.3829.26.camel@frecb000686>
	 <1149852951.7421.7.camel@Homer.TheSimpsons.net>
	 <1149853468.3829.33.camel@frecb000686>
	 <1149855638.7413.8.camel@Homer.TheSimpsons.net>
	 <1149857821.3829.42.camel@frecb000686>
	 <1149858713.5257.146.camel@localhost.localdomain>
	 <1149860558.7423.9.camel@Homer.TheSimpsons.net>
	 <1149868555.3187.25.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1149878466.7907.5.camel@Homer.TheSimpsons.net>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 21:09:45 +0200
Message-Id: <1149880185.5257.177.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 20:41 +0200, Mike Galbraith wrote:
> > What priority ?
> 
> Bare minimum.  None of the other tasks that were scheduled were rt in
> their own right though.

I tracked it down. Working on the fix.

	tglx


