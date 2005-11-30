Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVK3PNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVK3PNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVK3PNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:13:07 -0500
Received: from kanga.kvack.org ([66.96.29.28]:8065 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751265AbVK3PNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:13:06 -0500
Date: Wed, 30 Nov 2005 10:10:06 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130151006.GA23308@kvack.org>
References: <20051130042118.GA19112@kvack.org> <20051130130216.GL19515@wotan.suse.de> <1133357572.2825.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133357572.2825.35.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 02:32:51PM +0100, Arjan van de Ven wrote:
> > Looks good thanks. It will need longer testing though.
> 
> is it -mm ready?

I'd like to hear back on if suspend/resume works with it, as that is one 
of the areas I couldn't test.  The patch set is completely incremental, 
so we could merge the bits of it in a couple of steps.  The mb() in 
smpboot.c is an important bug fix and should be considered for immediate 
inclusion.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
