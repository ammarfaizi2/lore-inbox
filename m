Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbUK0RTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbUK0RTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUK0RRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 12:17:17 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:43444 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261275AbUK0RQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 12:16:56 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Tonnerre <tonnerre@thundrix.ch>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <41A8AF8F.8060005@osdl.org>
References: <19865.1101395592@redhat.com>
	 <20041127042942.GA10774@pauli.thundrix.ch>
	 <20041127035113.GK29035@parcelfarce.linux.theplanet.co.uk>
	 <41A8AF8F.8060005@osdl.org>
Content-Type: text/plain
Message-Id: <1101575782.21273.5347.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 27 Nov 2004 17:16:22 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-27 at 08:47 -0800, Randy.Dunlap wrote:
> Speaking of more explicit, there are various asm-ARCH header
> files that do or do not hide (via __KERNEL__) interfaces
> such as:	get_unaligned()
> and the atomic operations.
> 
> So are these Linux kernel exported APIs, or do they belong
> in some library?

Both of those are kernel-private and should not be visible.

-- 
dwmw2


