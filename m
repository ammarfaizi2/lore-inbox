Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVBFNCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVBFNCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVBFNCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:02:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:28821 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261207AbVBFNB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:01:58 -0500
Date: Sun, 6 Feb 2005 14:01:52 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206130152.GH30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107694800.22680.90.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> correct,
> http://lists.ximian.com/archives/public/mono-list/2004-June/021592.html
> 
> that fixes mono instead

Silent breakage => bad.

> 
> >  (and i suspect wine) and the others
> 
> wine is ok, it uses PROT_EXEC correctly for things it's not sure about.

Hmm, I got a report that it doesn't work anymore with 
2.6.11rcs on x86-64. I haven't looked  closely yet,
but it wouldn't surprise me if this change isn't also involved.

-Andi
