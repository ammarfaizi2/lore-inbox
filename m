Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWAJArP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWAJArP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWAJArP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:47:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751801AbWAJArO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:47:14 -0500
Date: Mon, 9 Jan 2006 16:46:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org, greg@kroah.com
Subject: Re: Problems with 2.6.15-mm1 and mm2.
Message-Id: <20060109164653.23b2676e.akpm@osdl.org>
In-Reply-To: <43C2FA2E.2040704@google.com>
References: <43C2A48F.6030407@google.com>
	<20060109154127.6a7e6972.akpm@osdl.org>
	<43C2FA2E.2040704@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@google.com> wrote:
>
> >>from the NUMA-Q. http://test.kernel.org/19793/debug/console.log
>  >>
>  > 
>  > 
>  > Yes, I asked Greg about that - we don't know what's causing it yet.  I have
>  > a bad feeling that this bug will go into Linus's tree if we don't fix it
>  > quick.
>  > 
>  > I had problems with gregkh-pci-x86-pci-domain-support-the-meat.patch.  It
>  > might be worth reverting that.
> 
>  Andy figured out what caused it.
> 
>  >>on -mm2 I get the x86_64 seems to lock up (NFI why ... looking at it), 
>  >>the NUMA-Q and x440 panic (very similar to the above).
>  >>
>  >>I think Andy figured out what was causing those panics. Can we drop 
>  >>those patches until they're fixed?
>  >>
>  > 
>  > 
>  > I'm not aware of any buggy x86_64 patches in -mm2 :(
>  > 
>  > I guess you don't have the time to sit down and do a bisection search. 
>  > It'd take a solid few hours...
> 
>  It's more that I don't have direct access to the machines in question
>  any more. The x86_64 one might just be a machine issue ... trying to 
>  confirm that still ... but the PCI one was real.
> 
>  M.
> 
>  Below is cut & pasted, so not applyable, and maybe it shouldn't be 
>  applied. But ... it worked before whatever is in -mm ... so my personal 
>  feeling is that if we don't have a fix for whatever is currently in -mm, 
>  it should get dropped until we do ? Going backwards = bad.
> 
>  Perhaps I'm in a time loop, and just confused. but I don't think so ?

This isn't at all clear, sorry.

Does the patch you sent fix things in 2.6.15-mm2?  On NUMAQ and on x86_64? 
Does it fix a bug which was introduced in a patch which in in 2.6.15-mm2? 
If so, which one?

etc ;)
