Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWEOQwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWEOQwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWEOQwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:52:31 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:35033 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964879AbWEOQwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:52:30 -0400
Subject: Re: rt20 scheduling latency testcase and failure data
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Darren Hart <dvhltc@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <1147671821.7633.13.camel@homer>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <20060513112039.41536fb5@mango.fruits>
	 <200605131106.16864.dvhltc@us.ibm.com>  <1147671821.7633.13.camel@homer>
Content-Type: text/plain
Date: Mon, 15 May 2006 12:52:27 -0400
Message-Id: <1147711948.27252.266.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 07:43 +0200, Mike Galbraith wrote:
> On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
> 
> > I haven't yet tried running with the RT Latency / Trace tools.  I can try 
> > those if folks they think they will be useful.
> 
> FWIW, enabling tracing made the 10ms failure variant fairly repeatable
> here.

Make sure you're not reading /proc/latency_trace during the test - it
will reliably cause missed deadlines.

Lee

