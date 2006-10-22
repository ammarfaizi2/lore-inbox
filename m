Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422911AbWJVCBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422911AbWJVCBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 22:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422927AbWJVCBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 22:01:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:43910 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422911AbWJVCBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 22:01:06 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       johnstul@us.ibm.com
Subject: Re: PAE broken on Thinkpad
References: <1161472697.5528.6.camel@localhost.localdomain>
	<1161481965.3128.129.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 22 Oct 2006 04:00:51 +0200
In-Reply-To: <1161481965.3128.129.camel@laptopd505.fenrus.org>
Message-ID: <p73r6x1m7n0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Sat, 2006-10-21 at 16:18 -0700, john stultz wrote:
> > Yea. So I know I probably shouldn't run a PAE kernel on my 1Gig laptop,
> > but in trying to do so I found it won't boot.
> 
> 
> which CPU do you have? Not all laptop processors support PAE at all...
> (for example the pentiumM generations before NX was added)

It shouldn't have crashed in bootmem then, just paniced early.

-Andi
