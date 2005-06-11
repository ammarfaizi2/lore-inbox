Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVFKRcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVFKRcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVFKRbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:31:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18422 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261765AbVFKRa4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:30:56 -0400
Date: Sat, 11 Jun 2005 10:30:41 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>
cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <42AB1F8D.30104@kolumbus.fi>
Message-ID: <Pine.LNX.4.10.10506111029290.27294-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, [UTF-8] Mika Penttilä wrote:

> ok, so maybe the safe way is to enforce threaded softirq with the soft 
> irq flag.
> 

That's already handled, my changes are used only when you turn on
PREEMPT_RT , and PREEMPT_RT forces softirq threading.

Daniel

