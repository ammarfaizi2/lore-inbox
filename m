Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266300AbTGJMJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbTGJMJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:09:53 -0400
Received: from asplinux.ru ([195.133.213.194]:14086 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S266300AbTGJMJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:09:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kirill Korotaev <dev@sw.ru>
Organization: SW Soft
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Date: Thu, 10 Jul 2003 16:33:06 +0400
User-Agent: KMail/1.4.2
References: <Pine.LNX.4.44.0307091656240.1654-100000@localhost.localdomain> <200307101450.42340.dev@sw.ru> <20030710123529.A6866@flint.arm.linux.org.uk>
In-Reply-To: <20030710123529.A6866@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307101633.06912.dev@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I haven't read the patches, but this caught my attention.
>
> Wasn't the use of cr3 there to ensure that we used the right page tables
> when fixing up page faults occuring in the middle of a context switch for
> interrupt handlers in kernel modules?
When 4gb split is used cr3 always(!) points to swapper pgdir when kernel code 
is executing, so it is not an issue.

Kirill

