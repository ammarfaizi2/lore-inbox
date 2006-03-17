Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWCQPB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWCQPB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 10:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWCQPB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 10:01:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:64230 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751192AbWCQPB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 10:01:26 -0500
Date: Fri, 17 Mar 2006 15:59:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jack Steiner <steiner@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
Message-ID: <20060317145912.GA13207@elte.hu>
References: <20060317145709.GA4296@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317145709.GA4296@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jack Steiner <steiner@sgi.com> wrote:

> 	Signed-off-by: Jack Steiner <steiner@sgi.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

>  extern int nr_processes(void);
>  extern unsigned long nr_running(void);
> +extern unsigned long nr_active(void);
>  extern unsigned long nr_uninterruptible(void);
>  extern unsigned long nr_iowait(void);

ob'nit, i'd make it:

>  extern int nr_processes(void);
>  extern unsigned long nr_running(void);
>  extern unsigned long nr_uninterruptible(void);
> +extern unsigned long nr_active(void);
>  extern unsigned long nr_iowait(void);

just to keep the logical order.

	Ingo
