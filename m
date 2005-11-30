Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbVK3ReL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbVK3ReL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVK3ReK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:34:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44474 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751484AbVK3ReI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:34:08 -0500
Date: Wed, 30 Nov 2005 17:33:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130173354.GA17064@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jari Ruusu <jariruusu@users.sourceforge.net>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Arjan van de Ven <arjan@infradead.org>,
	Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20051130042118.GA19112@kvack.org> <438D4905.9F023405@users.sourceforge.net> <1133337416.2825.18.camel@laptopd505.fenrus.org> <438D60B0.4020207@yahoo.com.au> <438DE183.439170CD@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438DE183.439170CD@users.sourceforge.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 07:29:39PM +0200, Jari Ruusu wrote:
> Calling convention change that breaks existing assembler code that has been
> field proven and is believed to be entirely free of bugs for long time, does
> NOT belong in a STABLE kernel series.
> 
> OTOH, if your business model requires breaking stuff and then milking your
> customers for "fixing" the breakage, then this type of change is
> understandable.  </sarcasm>

Please stop spreading bullshit.  Calling convetions can change all the
time.  The kernel only exports a C API and not ABI at all to modules.
And even the API is rather volatile and can change with every release.

Just because you're too much of a dickhead to work with others on the
inkernel crypto implementation we don't have to care about your unsupported
out of tree code.

