Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWHATPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWHATPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWHATPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:15:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:25514 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751815AbWHATPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:15:02 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/33] x86_64: Remove the identity mapping as early as possible.
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302462613-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:15:00 +0200
In-Reply-To: <11544302462613-git-send-email-ebiederm@xmission.com>
Message-ID: <p734pww1d57.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> With the rewrite of the SMP trampoline and the early page
> allocator there is nothing that needs identity mapped pages,
> once we start executing C code.

Cool.

Hopefully that can be done for i386 too. People on other architectures
have been complaining that i386 doesn't catch early NULL pointers.

-Andi
