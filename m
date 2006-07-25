Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWGYLtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWGYLtB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 07:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWGYLtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 07:49:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35242 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932332AbWGYLtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 07:49:00 -0400
Subject: Re: [PATCH for 2.6.18rc2] [1/7] i386/x86-64: Don't randomize stack
	top when...
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200607251338.45215.ak@suse.de>
References: <200607250508_MC3-1-C604-C1C9@compuserve.com>
	 <200607251338.45215.ak@suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 13:48:54 +0200
Message-Id: <1153828134.8932.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > > the 8K was what Intel proposed for 2.4 quite a while ago and has been in
> > > use in linux for years and years... Can you explain why you are saying
> > > 7Kb? throwing away that 1Kb of cache associativity is unfortunate and
> > > shouldn't be done unless there's a good reason, so I'm quite interested
> > > in finding out your reason ;)
> >
> > Well that's what the Intel IA-32 optimization manual says:
> 
> The reason I allowed to disable it is that it is sometimes very useful
> for debugging if you can get 100% reproducible addresses.

that I fully agree with; if you say as user "hey I don't care about
anything but give me no randomization" we should give the user no
randomization.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

