Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVBFRFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVBFRFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVBFRFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:05:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:22403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261213AbVBFRFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:05:21 -0500
Date: Sun, 6 Feb 2005 09:05:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
In-Reply-To: <20050206123355.GB30109@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0502060904140.2165@ppc970.osdl.org>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org>
 <20050206123355.GB30109@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Feb 2005, Andi Kleen wrote:
> 
> There are probably more.

So? Do you expect to never fix them, or what?

The fact is, a program that tries to execute without using PROT_EXEC is a 
buggy program. 

Are there buggy programs out there? Yes. We should fix them.

		Linus
