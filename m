Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbUK0AqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbUK0AqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbUK0Amq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:42:46 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:45528 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S263076AbUK0Ai0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:38:26 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Alexandre Oliva <aoliva@redhat.com>,
       dhowells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
In-Reply-To: <41A7CA94.60309@domdv.de>
References: <19865.1101395592@redhat.com>
	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	 <1101422103.19141.0.camel@localhost.localdomain>
	 <41A7C68D.3060302@domdv.de>
	 <1101515200.21273.4320.camel@baythorne.infradead.org>
	 <41A7CA94.60309@domdv.de>
Content-Type: text/plain
Message-Id: <1101515882.21273.4338.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 27 Nov 2004 00:38:02 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-27 at 01:30 +0100, Andreas Steinmetz wrote:
> I know very well about this problem. Still, you can easily use 64-bit 
> applications with regards to netfilter. If you are so annoyed about this 
> problem I would suggest you contact the netfilter developers to find a 
> solution :-)

It's a shame _they_ didn't know well about this problem five or so years
ago when the rest of us did. Oh well, it's on the list of things to
attempt when I can actually stomach it.

In the meantime, don't even think about claiming that netfilter is an
example of _anything_ which you can hold up as an example when we're
talking about cleaning stuff up. Breaking it in its current state would
be a feature, not a bug.

-- 
dwmw2


