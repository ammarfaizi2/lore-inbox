Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965598AbWKDSkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965598AbWKDSkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbWKDSkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:40:16 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:35750 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965598AbWKDSkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:40:14 -0500
Date: Sat, 4 Nov 2006 19:40:13 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <454A76CC.6030003@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A76CC.6030003@cosmosbay.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem with a per_cpu biglock is that you may consume a lot of RAM for 
> big NR_CPUS. Count 32 KB per 'biglock' if NR_CPUS=1024

Does one Linux kernel run on system with 1024 cpus? I guess it must fry 
spinlocks... (or even lockup due to spinlock livelocks)

Mikulas
