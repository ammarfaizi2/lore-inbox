Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263170AbUKZXiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbUKZXiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUKZTq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:46:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65474 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262415AbUKZT1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:19 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
In-Reply-To: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com>
	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Thu, 25 Nov 2004 22:35:02 +0000
Message-Id: <1101422103.19141.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-25 at 21:01 +0000, Matthew Wilcox wrote:
> I'm not particularly stuck on the <user/> namespace.  We could invent
> a better name.  How about <kern/> and <arch/> to replace <linux/>
> and <asm/>?  Obviously keeping linux/ and asm/ symlinks for backwards
> compatibility.

There's no _real_ need to keep them. All we need to fix is a handful of
libc implementations; anything else using them was broken anyway.

-- 
dwmw2

