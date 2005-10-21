Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVJUIGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVJUIGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 04:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVJUIGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 04:06:42 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25020
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964823AbVJUIGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 04:06:41 -0400
Subject: Re: ktimer API
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510210358040.3903@localhost.localdomain>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
	 <20051020073416.GA28581@elte.hu>
	 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
	 <20051020080107.GA31342@elte.hu>
	 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
	 <20051020085955.GB2903@elte.hu>
	 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
	 <1129826750.27168.163.camel@cog.beaverton.ibm.com>
	 <20051020193214.GA21613@elte.hu>
	 <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
	 <1129880977.16447.116.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0510210358040.3903@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 21 Oct 2005 10:09:14 +0200
Message-Id: <1129882155.16447.119.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 04:00 -0400, Steven Rostedt wrote:
> Thomas,
> 
> I noticed you changed the names around for ktimer_start/restart.  Is it OK
> to just use the restart, if you don't know if it has already started,
> every time, and never call the start.  It seems to be OK now, but will
> that ever change?

No. Note also that there are no functional changes in the code. Its only
a cleanup vs. coding style and namespaces.

> Basically, is just the ktimer_init good enough for ktimer_restart?

Yes

	tglx


