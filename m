Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWEPPZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWEPPZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWEPPZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:25:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:62656 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751224AbWEPPZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:25:12 -0400
Date: Tue, 16 May 2006 17:25:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 1/3] reliable stack trace support
Message-ID: <20060516152508.GA14174@elte.hu>
References: <4469FC07.76E4.0078.0@novell.com> <20060516143937.GA10760@elte.hu> <446A0A57.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446A0A57.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <jbeulich@novell.com> wrote:

> >>> Ingo Molnar <mingo@elte.hu> 16.05.06 16:39 >>>
> >> +config STACK_UNWIND
> >> +	bool "Stack unwind support"
> >> +	depends on UNWIND_INFO
> >> +	depends on n
> >
> >'depends on n' ? Also, i think this should be 'default y'. The code is 
> 
> Subsequent patches then change it to X86_64 and then X86. This is just 
> so the patch can be used standalone.

ok.

	Ingo
