Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUK1HVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUK1HVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 02:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUK1HVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 02:21:06 -0500
Received: from [213.146.154.40] ([213.146.154.40]:5297 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261406AbUK1HVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 02:21:04 -0500
Date: Sun, 28 Nov 2004 07:20:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Tonnerre <tonnerre@thundrix.ch>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041128072049.GA20169@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Woodhouse <dwmw2@infradead.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
	Tonnerre <tonnerre@thundrix.ch>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	aoliva@redhat.com, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <41A8AF8F.8060005@osdl.org> <1101575782.21273.5347.camel@baythorne.infradead.org> <200411272353.54056.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411272353.54056.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem with these (atomic.h, bitops.h, byteorder.h, div64.h,
> list.h, spinlock.h, unaligned.h and xor.h) is that they provide
> functionality that is needed by many user application but not
> provided by the compiler or libc. 

It's already broken on many architectures and just happens to work
on some.

