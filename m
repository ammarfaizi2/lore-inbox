Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbUJ2SDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUJ2SDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbUJ2R77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:59:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12989 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263337AbUJ2R5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:57:24 -0400
Date: Fri, 29 Oct 2004 10:57:05 -0700
From: Richard Henderson <rth@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-os@analogic.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
Message-ID: <20041029175705.GC25764@redhat.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:46:06AM -0700, Linus Torvalds wrote:
> Btw, this is another case where we _really_ want "asmlinkage" to mean that
> the compiler does not own the argument stack. Is there any chance of
> getting a function attribute like that into future versions of gcc?  

Certainly we'd accept the feature, it's just a matter of 
doing the work.  


r~
