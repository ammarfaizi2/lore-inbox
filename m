Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVGDJac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVGDJac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 05:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVGDJac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 05:30:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2780 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261509AbVGDJa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 05:30:28 -0400
Date: Mon, 4 Jul 2005 10:29:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "cutaway@bellsouth.net" <cutaway@bellsouth.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: function ordering (was: Re: [RFC] exit_thread() speedups in x86 process.c)
Message-ID: <20050704092958.GA29325@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hugh Dickins <hugh@veritas.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Denis Vlasenko <vda@ilport.com.ua>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	"cutaway@bellsouth.net" <cutaway@bellsouth.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Coywolf Qi Hunt <coywolf@gmail.com>
References: <200507012258_MC3-1-A340-3A81@compuserve.com> <200507021456.40667.vda@ilport.com.ua> <1120391140.3164.39.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0507031323280.6427@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507031323280.6427@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 01:30:23PM +0100, Hugh Dickins wrote:
> > this way we don't need to put a lot of __slow's in the code *and* it's
> > based on measurements not assumptions, and can be tuned for a specific
> > situation in addition.
> 
> This is reminiscent of "fur", whose source Old SCO opened.
> Google for SCO fur: amidst all the hits about "fur flying"
> you might find something useful!

Was it?  I was at Scaldera back in the days when it was supposed to get
opensourced, but AFAIK it never actually happened, everyone just talked
about it.

