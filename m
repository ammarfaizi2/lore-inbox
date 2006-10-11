Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWJKRNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWJKRNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWJKRNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:13:30 -0400
Received: from smtp-out.google.com ([216.239.45.12]:20406 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161116AbWJKRN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:13:29 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=FcU+zjKB9YZSic4oBWdB/hZr1Tf31EEsgosPWCGQ8b7HPX5a9l2ydovPsPnsvsznj
	Xemkodm+F3ecd4hJ+56tA==
Message-ID: <65dd6fd50610111013t6c783f3esc038c64abbcddeb0@mail.gmail.com>
Date: Wed, 11 Oct 2006 10:13:26 -0700
From: "Ollie Wild" <aaw@google.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Removing MAX_ARG_PAGES (request for comments/assistance)
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-mm@kvack.org, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@muc.de>, linux-arch@vger.kernel.org,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <1160553621.3000.355.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com>
	 <1160553621.3000.355.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on first sight it looks like you pin the entire userspace buffer at the
> same time (but I can misread the code; this stuff is a bit of a
> spaghetti by nature); that would be a DoS scenario if true...

I'm not sure I understand.  Could you please elaborate?

Thanks,
Ollie
