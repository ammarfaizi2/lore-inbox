Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWGHKpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWGHKpR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGHKpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:45:17 -0400
Received: from khc.piap.pl ([195.187.100.11]:38543 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751070AbWGHKpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:45:16 -0400
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       linux-os@analogic.com, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 08 Jul 2006 12:45:13 +0200
In-Reply-To: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com> (Albert Cahalan's message of "Fri, 7 Jul 2006 23:54:10 -0400")
Message-ID: <m3sllce5om.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> That's all theoretical though. Today, gcc's volatile does
> not follow the C standard on modern hardware. Bummer.
> It'd be low-performance anyway though.

I think gcc's volatile does in fact follow the standard. The standard
simply doesn't say anything about hardware accesses, SMP, PCI etc.
You must know what you're doing, and for some things you need a bit
of assembler.
-- 
Krzysztof Halasa
