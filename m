Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVHITWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVHITWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVHITWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:22:31 -0400
Received: from smtp.istop.com ([66.11.167.126]:50058 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932198AbVHITWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:22:30 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Wed, 10 Aug 2005 05:22:50 +1000
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
References: <42F57FCA.9040805@yahoo.com.au> <1123577509.30257.173.camel@gaston> <42F87C24.4080000@yahoo.com.au>
In-Reply-To: <42F87C24.4080000@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508100522.51297.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 August 2005 19:49, Nick Piggin wrote:
> Swsusp is the main "is valid ram" user I have in mind here. It
> wants to know whether or not it should save and restore the
> memory of a given `struct page`.

Why can't it follow the rmap chain?

Regards,

Daniel
