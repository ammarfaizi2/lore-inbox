Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbUK0AeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbUK0AeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbUK0Aas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:30:48 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:11220 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S263080AbUK0A1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:27:10 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Alexandre Oliva <aoliva@redhat.com>,
       dhowells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
In-Reply-To: <41A7C68D.3060302@domdv.de>
References: <19865.1101395592@redhat.com>
	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	 <1101422103.19141.0.camel@localhost.localdomain>
	 <41A7C68D.3060302@domdv.de>
Content-Type: text/plain
Message-Id: <1101515200.21273.4320.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 27 Nov 2004 00:26:40 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-27 at 01:13 +0100, Andreas Steinmetz wrote:
> And how do you want to deal with the fact that up to now all the 
> netfilter headers required for userspace programming live in the kernel 
> include tree? Now this has been like this for quite some years. Shall 
> one no longer use netfilter?

Don't get me started on fucking netfilter. Have you tried running 32-bit
userspace on a 64-bit kernel recently? Throw away the fucking netfilter
shite and burn it.

-- 
dwmw2


