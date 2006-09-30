Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWI3W7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWI3W7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWI3W7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:59:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751670AbWI3W7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:59:48 -0400
Date: Sat, 30 Sep 2006 15:59:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
In-Reply-To: <Pine.LNX.4.64.0609301554310.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609301559010.3952@g5.osdl.org>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <200609302230.24070.ak@suse.de> <Pine.LNX.4.64.0609301449130.3952@g5.osdl.org>
 <200610010002.46634.ak@suse.de> <Pine.LNX.4.64.0609301554310.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Sep 2006, Linus Torvalds wrote:
> 
> And you don't think that's true on x86?
> 
> Read the x86 code. Please. The one _before_ you added unwinding.

(Btw, on x86, all different stacks looked the same, since they were all 
irq stacks. If they don't look that way on x86-64, just fix _that_ part).

		Linus
