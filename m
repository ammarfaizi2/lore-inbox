Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVE3KWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVE3KWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVE3KWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:22:45 -0400
Received: from one.firstfloor.org ([213.235.205.2]:45714 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261228AbVE3KWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:22:44 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: phdm@macqel.be, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: PATCH : ppp + big-endian = kernel crash
References: <20050529.135257.98862077.davem@davemloft.net>
	<200505292138.j4TLcrJ28536@mail.macqel.be>
	<20050529.145509.82051753.davem@davemloft.net>
	<20050529195245.33f36253.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Mon, 30 May 2005 12:22:42 +0200
In-Reply-To: <20050529195245.33f36253.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 29 May 2005 19:52:45 -0700")
Message-ID: <m14qclxbbh.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>> 
>> So many variants of tunneling and protocol encapsulation can result in
>> unaligned packet headers, and as a result platforms really must
>> provide proper unaligned memory access handling in kernel mode in
>> order to use the networking fully.
>
> As Philippe mentioned, old 68k's simply cannot do this.

An 68000 cannot, but 68010+ can. Are there really that many 68000 users
left? 

-Andi
