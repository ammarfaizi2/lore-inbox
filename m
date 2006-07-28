Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWG1I7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWG1I7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWG1I7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:59:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61905 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161103AbWG1I7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:59:19 -0400
Date: Fri, 28 Jul 2006 10:53:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Morris <jmorris@namei.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] ipc/msg.c: clean up coding style
Message-ID: <20060728085315.GA14622@elte.hu>
References: <20060727135321.GA24644@elte.hu> <20060727144659.GC6825@martell.zuzino.mipt.ru> <20060727162434.GA29489@elte.hu> <Pine.LNX.4.64.0607280153490.13981@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607280153490.13981@d.namei>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* James Morris <jmorris@namei.org> wrote:

> On Thu, 27 Jul 2006, Ingo Molnar wrote:
> 
> > > Let's not go BSD way.
> > 
> > again, lets not have overlong line 80 prototypes.
> 
> I thought Linus gave his blessing for long lines for prototypes (up to 
> 120 chars?), to make it easier to grep the code for function 
> prototypes.

i think that's a tool issue. If you need multiline grep, use the 'mg' 
perl-script from:

  http://freshmeat.net/projects/mg_multi_line_grep/

for example, to see all syscall prototypes in kernel/*.c:

  mg -e "asmlinkage.*\n*.*sys.*\n*.*{" kernel/*.c

	Ingo
