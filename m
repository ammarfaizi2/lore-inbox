Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWHATLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWHATLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWHATLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:11:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:682 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751812AbWHATLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:11:40 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/33] x86_64: Relocatable kernel support
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302483667-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:11:38 +0200
In-Reply-To: <11544302483667-git-send-email-ebiederm@xmission.com>
Message-ID: <p73d5bk1dat.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:
> 
> When loaded with a normal bootloader the decompressor will decompress
> the kernel to 2M and it will run there.  This both ensures the
> relocation code is always working, and makes it easier to use 2M
> pages for the kernel and the cpu.

It would have been nicer if you had moved the uncompressor to be 64bit
first like it was planned for a long time.

-Andi
