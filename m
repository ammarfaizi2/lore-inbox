Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVFOXif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVFOXif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFOXif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:38:35 -0400
Received: from mollusk.mweb.co.za ([196.2.24.27]:62590 "EHLO
	mollusk.mweb.co.za") by vger.kernel.org with ESMTP id S261663AbVFOXiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:38:22 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tracking a bug in x86-64
Date: Thu, 16 Jun 2005 01:39:04 +0200
User-Agent: KMail/1.8.50
Cc: Andrew Morton <akpm@osdl.org>, ak@muc.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
References: <200506132259.22151.bonganilinux@mweb.co.za> <200506160020.21688.bonganilinux@mweb.co.za> <Pine.LNX.4.58.0506151536000.8487@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506151536000.8487@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506160139.04389.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 12:39 am, Linus Torvalds wrote:
> 
> On Thu, 16 Jun 2005, Bongani Hlope wrote:
> >
> > push 410, pop 205, pop 103, push 103, pop 51, pop 26, push 13, pop 6, push 4 and push 1
> > This points to: randomisation-top-of-stack-randomization.patch
> 
> Goodie.
> 
> Can you verify (just to make doubly sure that there are no subtle
> interactions anywhere) that the current top-of-tree with that _one_ patch
> reverted ends up working for you?
> 
> Anyway, thanks a heap for spending the time narrowing this down!
> 
> 		Linus

Hi Linus

I just tested, 2.6.12-rc6 minus randomisation-top-of-stack-randomization.patch Works For Me (tm)

