Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbUJ2T04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUJ2T04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUJ2T0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:26:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16341 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263498AbUJ2Sfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:35:51 -0400
Date: Fri, 29 Oct 2004 11:35:24 -0700
From: Richard Henderson <rth@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-os@analogic.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
Message-ID: <20041029183524.GD25764@redhat.com>
References: <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <20041029151139.GA73646@muc.de> <Pine.LNX.4.58.0410291114300.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410291114300.28839@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:18:33AM -0700, Linus Torvalds wrote:
> What's happens if there are more arguments than three? It happens for 
> several system calls - does gcc still consider the stack part of the thing 
> to be owned by the callee?

Yes.


r~
