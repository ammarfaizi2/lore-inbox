Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTIPMFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbTIPMFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:05:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:17300 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261831AbTIPMFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:05:18 -0400
Date: Tue, 16 Sep 2003 13:05:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Felipe W Damasio <felipewd@terra.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/futex.c: Uneeded memory barrier
Message-ID: <20030916120510.GI26576@mail.jlokier.co.uk>
References: <3F621160.5020502@terra.com.br> <20030915143538.009B32C0C3@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030915143538.009B32C0C3@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3F621160.5020502@terra.com.br> you write:
> > >     Kills an unneeded set_current_state after schedule_timeout, since it 
> > > already guarantees that the task will be TASK_RUNNING.
> 
> In fact, furthur cleanups are possible.

I agree, nice cleanups :)

-- Jamie
