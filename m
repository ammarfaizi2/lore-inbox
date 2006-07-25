Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWGYFSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWGYFSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWGYFSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:18:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62941 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932461AbWGYFST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:18:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Edgar Hucek <hostmaster@ed-soft.at>, torvalds@osdl.org, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add efi e820 memory mapping on x86 [try #1]
References: <44A04F5F.8030405@ed-soft.at>
	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	<44A0CCEA.7030309@ed-soft.at>
	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
	<44A304C1.2050304@zytor.com>
	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
	<44A8058D.3030905@zytor.com>
	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>
	<44AB8878.7010203@ed-soft.at>
	<m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
	<44B6BF2F.6030401@ed-soft.at>
	<Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
	<44B73791.9080601@ed-soft.at>
	<Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
	<44B9FF02.3020600@ed-soft.at> <20060724212911.32dd3bc0.akpm@osdl.org>
Date: Mon, 24 Jul 2006 23:17:07 -0600
In-Reply-To: <20060724212911.32dd3bc0.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 24 Jul 2006 21:29:11 -0700")
Message-ID: <m18xmimffw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Sun, 16 Jul 2006 10:55:30 +0200
> Edgar Hucek <hostmaster@ed-soft.at> wrote:
>
>> This Patch add an efi e820 memory mapping.
>> 
>
> Why?

The x86 architecture needs a way to represent the firmware supplied
memory map in a way that later code can query what is in the map.  The
easiest way to do this is simply to convert the efi memory map into
an e820 memory map.

Eric
