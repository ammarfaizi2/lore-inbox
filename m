Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbVJUIAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVJUIAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 04:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVJUIAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 04:00:43 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:20146 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964904AbVJUIAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 04:00:42 -0400
Date: Fri, 21 Oct 2005 04:00:37 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org
Subject: ktimer API
In-Reply-To: <1129880977.16447.116.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0510210358040.3903@localhost.localdomain>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> 
 <20051020073416.GA28581@elte.hu>  <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
  <20051020080107.GA31342@elte.hu>  <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
  <20051020085955.GB2903@elte.hu>  <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
  <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain> 
 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain> 
 <1129826750.27168.163.camel@cog.beaverton.ibm.com>  <20051020193214.GA21613@elte.hu>
  <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
 <1129880977.16447.116.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas,

I noticed you changed the names around for ktimer_start/restart.  Is it OK
to just use the restart, if you don't know if it has already started,
every time, and never call the start.  It seems to be OK now, but will
that ever change?

Basically, is just the ktimer_init good enough for ktimer_restart?

Thanks,

-- Steve


