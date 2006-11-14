Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966463AbWKNXkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966463AbWKNXkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966479AbWKNXkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:40:08 -0500
Received: from elvis.mu.org ([192.203.228.196]:31195 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S966463AbWKNXkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:40:06 -0500
Message-ID: <455A53CD.3010602@FreeBSD.org>
Date: Tue, 14 Nov 2006 15:39:57 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 0/1] Try 2: Make the TSC safe to be use by gettimeofday().
References: <455A512F.6030907@FreeBSD.org>
In-Reply-To: <455A512F.6030907@FreeBSD.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suleiman Souhlal wrote:
> Hi,
> 
> Here are the fixes from the previous version:
> - Remove usage of preempt_disable/enable() in do_gettimeoday(), since 
> the above fix make it
>  unnecessary.

Oops, this is not actually in the patch, because the preempt_disable()/enable() are
still needed.
The patch I sent out is correct.

-- Suleiman
