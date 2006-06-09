Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbWFINLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbWFINLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWFINLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:11:34 -0400
Received: from www.osadl.org ([213.239.205.134]:51844 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965252AbWFINLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:11:33 -0400
Subject: Re: 2.6.17-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149857821.3829.42.camel@frecb000686>
References: <20060607211455.GA6132@elte.hu>
	 <1149842550.7585.27.camel@Homer.TheSimpsons.net>
	 <1149847951.3829.26.camel@frecb000686>
	 <1149852951.7421.7.camel@Homer.TheSimpsons.net>
	 <1149853468.3829.33.camel@frecb000686>
	 <1149855638.7413.8.camel@Homer.TheSimpsons.net>
	 <1149857821.3829.42.camel@frecb000686>
Content-Type: text/plain; charset=utf-8
Date: Fri, 09 Jun 2006 15:11:53 +0200
Message-Id: <1149858713.5257.146.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 14:57 +0200, Sébastien Dugué wrote:
> All the round trips under strace are in the 2ms range.
> 
>   How on earth can it be that stracing the ping gives better
> performance???

Was busy fixing a scheduling while atomic bug. I just verified that I
have the same weird behaviour. I'm looking into it.

	tglx


