Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVARIq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVARIq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVARIq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:46:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64150
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261186AbVARIqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:46:22 -0500
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>
In-Reply-To: <41EC50E6.2080706@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105742791.13265.3.camel@tglx.tec.linutronix.de>
	 <41E8543A.8050304@am.sony.com>
	 <1105794499.13265.247.camel@tglx.tec.linutronix.de>
	 <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>
	 <41E9EC5A.7070502@opersys.com>
	 <1105919017.13265.275.camel@tglx.tec.linutronix.de>
	 <41EB1AEC.3000106@opersys.com>
	 <1105957604.13265.388.camel@tglx.tec.linutronix.de>
	 <41EC2157.1070504@opersys.com>
	 <1106000307.13265.462.camel@tglx.tec.linutronix.de>
	 <41EC50E6.2080706@opersys.com>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 09:46:10 +0100
Message-Id: <1106037970.16877.21.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 18:57 -0500, Karim Yaghmour wrote: 
> Thomas Gleixner wrote:
> > If we add another hardwired implementation then we do not have said
> > benefits.
> 
> Please stop handwaving. Folks like Andrew, Christoph, Zwane, Roman,
> and others actually made specific requests for changes in the code.
> What makes you think you're so special that you think you are
> entitled to stay on the side and handwave about concepts.

So the points you added to your todo list which were brought up by me
are worthless ?

I'm not handwaving. I started this RFC to move the discussion into a
general discussion about instrumentation. A couple of people are
seriosly interested to do this. If you are not interested then ignore
the thread, but you're way not in a position to tell me to shut up.

You turned this thread into your LTT prayer wheel.

Roman pointed out your unwillingness to create a common framework
before. But I have to disagree with him in one point. It's not amazing,
it's annoying.

> If there is a limitation with the code, please present actual
> snippets that need to be changed and suggest alternatives. That's
> what everyone else does on this list.

I pointed you to actually broken code and you accused me of throwing
mud.

> Save the bandwidth 

Please remove me from cc, it's a good start to save bandwidth.

> and start cleaning.

Yes, I did already start cleaning

cat ../broken-out/ltt* | patch -p1 -R

tglx


