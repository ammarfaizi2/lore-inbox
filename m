Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264081AbRFNVpC>; Thu, 14 Jun 2001 17:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264086AbRFNVoo>; Thu, 14 Jun 2001 17:44:44 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:15118 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264081AbRFNVoY>;
	Thu, 14 Jun 2001 17:44:24 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106142143.f5ELhqm453893@saturn.cs.uml.edu>
Subject: Re: unregistered changes to the user<->kernel API
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 14 Jun 2001 17:43:52 -0400 (EDT)
Cc: andrea@suse.de (Andrea Arcangeli), jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org, rth@redhat.com (Richard Henderson)
In-Reply-To: <E15AbaZ-00054p-00@the-village.bc.nu> from "Alan Cox" at Jun 14, 2001 07:11:27 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> I dont see why Tux should be merged. If we have people achieving the same
> performance in user space with the core facilities tux added to the kernel
> like the better irq/sendfile stuff why bother merging tux ?

1. We have khttpd, which should be replaced by something faster.
2. Tux makes a nice example.
3. Tux can be the fastest. If it isn't, it needs more work.

Toward the end of the X15 discussion, Ingo Molnar mentioned
something he'd not implemented yet. I don't recall exactly,
but for sure Tux hasn't run out of optimizations to do.

Also the kernel-CGI feature has not been used in benchmarks.
Tux has been running user code.

IMHO the Tux server could be renamed "khttpd" and dropped in
with whatever is needed to be compatible for existing setups.
