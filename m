Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVJBXzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVJBXzP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVJBXzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:55:15 -0400
Received: from florence.buici.com ([206.124.142.26]:49113 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1751157AbVJBXzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:55:14 -0400
Date: Sun, 2 Oct 2005 16:55:13 -0700
From: Marc Singer <elf@buici.com>
To: jonathan@jonmasters.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Discontiguous memory fun
Message-ID: <20051002235512.GA15138@buici.com>
References: <35fb2e5905090110171aa77266@mail.gmail.com> <35fb2e590510021157l63f6a270l2810659427a8fa9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590510021157l63f6a270l2810659427a8fa9e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 07:57:30PM +0100, Jon Masters wrote:
> Replying to my own post...
> 
> On 9/1/05, Jon Masters <jonmasters@gmail.com> wrote:
> 
> I'd love to know what the state of discontig memory is like on 2.6
> series ARM kernels and highmem too for that matter, but I've not had
> chance to look at it (I'm usually a ppc guy).

It works fine.

The node mapping is performed by macros in asm-arm/arch-*/memory.h.
