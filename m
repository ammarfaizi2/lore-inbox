Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVLNSbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVLNSbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVLNSbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:31:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11216 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964835AbVLNSbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:31:08 -0500
To: Dave <dave.jiang@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 segfault error codes
References: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2005 19:31:07 +0100
In-Reply-To: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com>
Message-ID: <p73hd9b8r9w.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave <dave.jiang@gmail.com> writes:

> For segfault error codes on x86_64, bits 0-3 are documented in
> arch/x86_64/mm/fault.c. However, I am getting error 0x14 and 0x15 with this
> particular user app when it segfaults. Is bit 4 valid and what does that
> imply?

bit 4 is documented too in 2.6. It means it was an instruction fetch.
The error code is just the architectural error code for page faults
BTW, see the Intel and AMD manuals for details.

-Andi
