Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWHBCDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWHBCDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWHBCDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:03:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11428 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751014AbWHBCDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:03:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<20060801192628.GE7054@in.ibm.com> <44CFB8C4.8060904@zytor.com>
Date: Tue, 01 Aug 2006 20:02:05 -0600
In-Reply-To: <44CFB8C4.8060904@zytor.com> (H. Peter Anvin's message of "Tue,
	01 Aug 2006 13:25:40 -0700")
Message-ID: <m1hd0vyjxe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Vivek Goyal wrote:
>> Hi Eric,
>> Can't we use the x86_64 relocation approach for i386 as well? I mean keep
>> the virtual address space fixed and updating the page tables. This would
>> help in the sense that you don't have to change gdb if somebody decides to
>> debug the relocated kernel.
>> Any such tool that retrieves the symbol virtual address from vmlinux will
>> be confused.
>>
>
> I don't think this is practical given the virtual space constraints on i386
> systems.

Exactly.

Plus it is a lot of dangerous work.   Processing is a lot more
conservative.

Eric
