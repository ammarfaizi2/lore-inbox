Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318517AbSGSRq3>; Fri, 19 Jul 2002 13:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSGSRq2>; Fri, 19 Jul 2002 13:46:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55289 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318517AbSGSRq2>; Fri, 19 Jul 2002 13:46:28 -0400
Subject: Re: [PATCH] per-cpu patch 2/3
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020719014425.9F57E4109@lists.samba.org>
References: <20020719014425.9F57E4109@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Jul 2002 10:49:28 -0700
Message-Id: <1027100968.1116.194.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 18:36, Rusty Russell wrote:

> I think you are confused: this patch is an enhancement of the per-cpu
> variable infrastructure.  I was making an analogy with
> smp_processor_id().
> 
> +#define get_cpu_var(var) ({ preempt_disable(); __get_cpu_var(var); })
> +#define put_cpu_var(var) preempt_enable()
> 
> Clear?

as day.

sorry,

	Robert Love

