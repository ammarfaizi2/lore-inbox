Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVLPLaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVLPLaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVLPLaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:30:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56530 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751007AbVLPLap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:30:45 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11202.1134730942@warthog.cambridge.redhat.com> 
References: <11202.1134730942@warthog.cambridge.redhat.com>  <43A21E55.3060907@yahoo.com.au> <1134560671.2894.30.camel@laptopd505.fenrus.org> <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 16 Dec 2005 11:30:01 +0000
Message-ID: <12186.1134732601@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> No, they're not. LL/SC is more flexible than CMPXCHG because under some
> circumstances, you can get away without doing the SC,

Of course, CMPXCHG doesn't have to store either, though it still performs a
locked-write-cycle on x86 if I remember correctly.

David
