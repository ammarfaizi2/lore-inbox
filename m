Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUJEAl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUJEAl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268724AbUJEAl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:41:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:25812 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268726AbUJEAlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:41:49 -0400
X-Authenticated: #4399952
Date: Tue, 5 Oct 2004 02:56:42 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       thewade <pdman@aproximation.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
Message-ID: <20041005025642.4fbc0775@mango.fruits.de>
In-Reply-To: <1096936317.16648.103.camel@krustophenia.net>
References: <20040919122618.GA24982@elte.hu>
	<414F8CFB.3030901@cybsft.com>
	<20040921071854.GA7604@elte.hu>
	<20040921074426.GA10477@elte.hu>
	<20040922103340.GA9683@elte.hu>
	<20040923122838.GA9252@elte.hu>
	<20040923211206.GA2366@elte.hu>
	<20040924074416.GA17924@elte.hu>
	<20040928000516.GA3096@elte.hu>
	<20041003210926.GA1267@elte.hu>
	<20041004215315.GA17707@elte.hu>
	<1096936317.16648.103.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Oct 2004 20:31:58 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2004-10-04 at 17:53, Ingo Molnar wrote:
> > i've released the -S9 VP patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
> > 
> 
> Does not compile:

The definition of hardirq_stack seem to depend on the 4k stacks option.
with this enables it builds past irq.c.

flo
