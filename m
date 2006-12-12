Return-Path: <linux-kernel-owner+w=401wt.eu-S932163AbWLLJQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWLLJQk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWLLJQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:16:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:36740 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbWLLJQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:16:39 -0500
Message-ID: <457E7374.3000704@qumranet.com>
Date: Tue, 12 Dec 2006 11:16:36 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/kvm/: possible cleanups
References: <20061211184051.GC28443@stusta.de>
In-Reply-To: <20061211184051.GC28443@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - proper prototype for kvm_main.c:find_msr_entry()
> - #if 0 the unused svm.c:inject_db()
>
>   

Please copy kvm patches to kvm-devel@lists.sourceforge.net in the future.

find_msr_entry() has been moved to vmx.c by another patch (now queued in 
-mm), so this patch does not apply.  The rest of the cleanups do look 
good though.

While I'll accept cleanup patches for kvm, there are other sources of 
churn right now, so it might be more efficient to wait with the cleanups 
for a few weeks.

-- 
error compiling committee.c: too many arguments to function

