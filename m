Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWGYG03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWGYG03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWGYG03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:26:29 -0400
Received: from terminus.zytor.com ([192.83.249.54]:36241 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751444AbWGYG03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:26:29 -0400
Message-ID: <44C5B981.2050909@zytor.com>
Date: Mon, 24 Jul 2006 23:26:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Edgar Hucek <hostmaster@ed-soft.at>,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add efi e820 memory mapping on x86 [try #1]
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org> <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org> <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com> <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com> <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com> <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org> <44B73791.9080601@ed-soft.at> <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org> <44B9FF02.3020600@ed-soft.at> <20060724212911.32dd3bc0.akpm@osdl.org> <Pine.LNX.4.64.0607242227340.29649@g5.osdl.org> <44C5AD50.1020305@zytor.com> <Pine.LNX.4.64.0607242241390.29649@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607242241390.29649@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 24 Jul 2006, H. Peter Anvin wrote:
>> You're forgetting PXE.
> 
> I don't think I'm forgetting it as much as just repressing it. I don't 
> think it actually affects the kernel, does it? I assume the only reason 
> you care is that it might affect a bootloader?
> 

Well, one could write an UNDI (PXE) network driver for Linux.  Whether 
or not one would want to is another matter...

It obviously affects the bootloader.

	-hpa
