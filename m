Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317960AbSGPUgT>; Tue, 16 Jul 2002 16:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317974AbSGPUgS>; Tue, 16 Jul 2002 16:36:18 -0400
Received: from code.and.org ([63.113.167.33]:21971 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S317960AbSGPUgR>;
	Tue, 16 Jul 2002 16:36:17 -0400
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Muli Ben-Yehuda <mulix@actcom.co.il>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: compile the kernel with -Werror
References: <20020713102615.H739@alhambra.actcom.co.il>
	<200207131541.37310.roy@karlsbakk.net>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 16 Jul 2002 16:36:49 -0400
In-Reply-To: <200207131541.37310.roy@karlsbakk.net>
Message-ID: <m3it3fo1em.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:

> On Saturday 13 July 2002 09:26, Muli Ben-Yehuda wrote:
> > A full kernel compilation, especially when using the -j switch to
> > make, can cause warnings to "fly off the screen" without the user
> > noticing them. For example, wli's patch lazy_buddy.2.5.25-1 of today
> > had a missing return statement in a function returning non void, which
> > the compiler probably complained about but the warning got lost in the
> > noise (a little birdie told me wli used -j64).
> 
> Why not add a menu item under kernel hacking?

 FFS....

make bzImage > compile.log 2> errors.log

-- 
James Antill -- james@and.org
"Although I have found authors who assert that the use of internal loop exits
is wrong, I have encountered none that support their claims with objective
evidence." -- Eric S. Roberts, Loop Exits and Structured Programming
