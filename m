Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWGYFpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWGYFpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWGYFpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:45:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59797 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932473AbWGYFpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:45:02 -0400
Date: Mon, 24 Jul 2006 22:44:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andrew Morton <akpm@osdl.org>, Edgar Hucek <hostmaster@ed-soft.at>,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add efi e820 memory mapping on x86 [try #1]
In-Reply-To: <44C5AD50.1020305@zytor.com>
Message-ID: <Pine.LNX.4.64.0607242241390.29649@g5.osdl.org>
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
 <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
 <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
 <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
 <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
 <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
 <44B73791.9080601@ed-soft.at> <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
 <44B9FF02.3020600@ed-soft.at> <20060724212911.32dd3bc0.akpm@osdl.org>
 <Pine.LNX.4.64.0607242227340.29649@g5.osdl.org> <44C5AD50.1020305@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jul 2006, H. Peter Anvin wrote:
> 
> You're forgetting PXE.

I don't think I'm forgetting it as much as just repressing it. I don't 
think it actually affects the kernel, does it? I assume the only reason 
you care is that it might affect a bootloader?

		Linus
