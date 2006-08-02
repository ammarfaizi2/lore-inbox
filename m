Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWHBC0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWHBC0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWHBC0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:26:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53916 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751068AbWHBC0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:26:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/33] x86_64: Relocatable kernel support
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302483667-git-send-email-ebiederm@xmission.com>
	<p73d5bk1dat.fsf@verdi.suse.de>
Date: Tue, 01 Aug 2006 20:25:08 -0600
In-Reply-To: <p73d5bk1dat.fsf@verdi.suse.de> (Andi Kleen's message of "01 Aug
	2006 21:11:38 +0200")
Message-ID: <m1vepbx4aj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>> 
>> When loaded with a normal bootloader the decompressor will decompress
>> the kernel to 2M and it will run there.  This both ensures the
>> relocation code is always working, and makes it easier to use 2M
>> pages for the kernel and the cpu.
>
> It would have been nicer if you had moved the uncompressor to be 64bit
> first like it was planned for a long time.

Sorry.  I wasn't really in those discussions.

I guess I could take this in some slightly smaller steps.
But this does wind up with decompressor being 64bit code.

Eric
