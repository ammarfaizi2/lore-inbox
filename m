Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270484AbUJUO2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270484AbUJUO2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUJUO2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:28:00 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:6275 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S270679AbUJUOZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:25:46 -0400
Date: Thu, 21 Oct 2004 16:26:53 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041021142653.GK8756@dualathlon.random>
References: <4177BBFD.5090300@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177BBFD.5090300@ttnet.net.tr>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 04:39:09PM +0300, O.Sezer wrote:
> I can't find to which suse kernel these patch(es) apply. I assume
> your first one comes down to the attached one-liner for vanilla-2.4,
> can you confirm?

yes.

> For your second: I think it needs your 9999_z-get_user_pages_pte_pin-1
> patch applied beforehand?. Without that patch, are there any problems

... plus yet another incremental patch not yet in 2.4.23aa3.  I'll
upload an aa4 soon with all of this included.

> to be fixed? Can you post patches for vanilla kernels, please?

I'll upload an aa4, then the future 9999_z-get_user_pages_pte_pin-2 will
included every known fix to get_user_pages. I hope it's the same for
you. I've a set of incremental fixes, and I'll join all of them together
in 9999_z-get_user_pages_pte_pin-2 (the PageReserved fix will get mixed
into it too, I hope that's not too confusing, the idea is that such
patch will fix all issues in get_user_pages in 2.4).
