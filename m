Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756177AbWKRGkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbWKRGkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbWKRGkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:40:12 -0500
Received: from main.gmane.org ([80.91.229.2]:25485 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1756177AbWKRGkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:40:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [RFC 6/7] Use an external declaration in exit.c for fs_cachep
Date: Sat, 18 Nov 2006 06:37:19 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrneltauh.dd3.olecom@flower.upol.cz>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com> <20061118054413.8884.99940.sendpatchset@schroedinger.engr.sgi.com> <20061118173253.85d5b7e8.sfr@canb.auug.org.au>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-18, Stephen Rothwell wrote:
[]
>> --- linux-2.6.19-rc5-mm2.orig/kernel/exit.c	2006-11-15 16:48:11.485511089 -0600
>> +++ linux-2.6.19-rc5-mm2/kernel/exit.c	2006-11-17 23:04:09.764530373 -0600
>> @@ -48,6 +48,8 @@
>>  #include <asm/pgtable.h>
>>  #include <asm/mmu_context.h>
>>
>> +extern kmem_cache_t *fs_cachep;
>
> You know what I am going to say, right? :-)

I know, externs must be in headers. Please, explain why.

TIA.
____

