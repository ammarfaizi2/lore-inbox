Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVALVYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVALVYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVALVVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:21:50 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:56773 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261364AbVALVPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:15:53 -0500
Message-ID: <41E59387.5050503@am.sony.com>
Date: Wed, 12 Jan 2005 13:15:51 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Reynolds, Terry (Contractor-SIMTECH)" <terry.reynolds2@us.army.mil>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Realtime-preemtp-2.6.10...-01 on a ppc64?
References: <CE14215C87EAAF4B9AD862BB49625057048E820C@ssdd-cluster.ds.amrdec.army.mil>
In-Reply-To: <CE14215C87EAAF4B9AD862BB49625057048E820C@ssdd-cluster.ds.amrdec.army.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reynolds, Terry (Contractor-SIMTECH) wrote:
> Hi all,
>  
> I've installed the patches on 2.6.10 (2.6.10-mm1 & realtime-preempt-2.6.10
> ... .34-01) on my G5 desktop.  The realtime patched kernel wont compile, as
> it has a large number of re-defined & conflicting types.  Including:
>  
> spinlock_t
> rwlock_t
> SPIN_LOCK_UNLOCKED
> RW_LOCK_UNLOCKED
> and lots of _raw_.*lock types.
>  
> It seems the ppc64 architecture hasn't been fleshed out yet for the
> real-time preemption patches, or did I just do something moronic?

As far as I know, realtime-preempt is not supported on any PPC (32 or 
64-bit).  I've been planning on working on some of the PPC 32-bit stuff,
but haven't had much time so far.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
