Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269212AbTGJLU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbTGJLU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:20:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24846 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269212AbTGJLU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:20:56 -0400
Date: Thu, 10 Jul 2003 12:35:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Kirill Korotaev <dev@sw.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <20030710123529.A6866@flint.arm.linux.org.uk>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307091656240.1654-100000@localhost.localdomain> <200307101450.42340.dev@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307101450.42340.dev@sw.ru>; from dev@sw.ru on Thu, Jul 10, 2003 at 02:50:42PM +0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 02:50:42PM +0400, Kirill Korotaev wrote:
> > > - I changed do_page_fault to setup vmalloced pages to current->mm->pgd
> > >  instead of cr3 context.

I haven't read the patches, but this caught my attention.

Wasn't the use of cr3 there to ensure that we used the right page tables
when fixing up page faults occuring in the middle of a context switch for
interrupt handlers in kernel modules?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

