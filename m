Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUKQDPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUKQDPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUKQDPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:15:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:43192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbUKQDPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:15:11 -0500
Date: Tue, 16 Nov 2004 19:14:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: dhowells@redhat.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
In-Reply-To: <20041116182841.4ff7f2e5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411161912180.2222@ppc970.osdl.org>
References: <2315.1100630906@redhat.com> <Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org>
 <20041116182841.4ff7f2e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Nov 2004, Andrew Morton wrote:
> 
> So I'd suggest that we make compound pages conditional on a new
> CONFIG_COMPOUND_PAGE and make that equal to HUGETLB_PAGE || !MMU.

That sounds sane, and seems easily done in init/Kconfig. David?

[ There's too damn many Davids around. DavidH? Mr Howells? Dude? ]

	Linus
