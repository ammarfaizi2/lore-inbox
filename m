Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWI3WzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWI3WzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWI3WzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:55:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751668AbWI3WzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:55:18 -0400
Date: Sat, 30 Sep 2006 15:55:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <200610010002.46634.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609301554310.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <200609302230.24070.ak@suse.de> <Pine.LNX.4.64.0609301449130.3952@g5.osdl.org>
 <200610010002.46634.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Oct 2006, Andi Kleen wrote:
> 
> No, it's not. On x86-64 it can be three or more stacks nested in
> complicated ways (process stack, interrupt stack, exception stack)
> The exception stack can happen multiple times.

And you don't think that's true on x86?

Read the x86 code. Please. The one _before_ you added unwinding.

		Linus
