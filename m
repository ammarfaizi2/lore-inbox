Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWDTNY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWDTNY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWDTNY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:24:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12441 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750927AbWDTNY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:24:57 -0400
Date: Thu, 20 Apr 2006 14:24:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060420132454.GB10415@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
	linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73mzeh2o38.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 12:32:43AM +0200, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> > 
> > you must have a good defense against that argument, so I'm curious to
> > hear what it is
> 
> [I'm not from the apparmor people but my understanding is]
> 
> Usually they claimed name spaces as the reason it couldn't work.
> 
> In practice AFAIK basically nobody uses name spaces for
> anything.

That;s mostly because we were missing feature to actually make them
usable.  One of them was the shared subtree works which now is in
and will be used in practice by things like clearcase.  The second big
thing we're missing is support to call mount() without addition privilegues.

