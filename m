Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVLPP6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVLPP6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLPP6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:58:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56331 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932339AbVLPP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:58:23 -0500
Date: Fri, 16 Dec 2005 15:58:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linh Dang <linhd@nortel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051216155811.GE1222@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Linh Dang <linhd@nortel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
	hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com> <43A2BAA7.5000807@yahoo.com.au> <20051216132123.GB1222@flint.arm.linux.org.uk> <wn564ppnohn.fsf@linhd-2.ca.nortel.com> <20058.1134748001@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20058.1134748001@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:46:41PM +0000, David Howells wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > Do you now see what I mean?  (yup, ARM is a llsc architecture.)
> 
> Out of interest, at what point did ARM become so? ARM6?

Yes, ARM architecture version 6.

See the ldrex (load exclusive) / strex (store exclusive) instructions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
