Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUL3HUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUL3HUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUL3HUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:20:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:1965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261555AbUL3HUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:20:41 -0500
Date: Wed, 29 Dec 2004 23:20:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: kernel@kolivas.org, solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
Message-Id: <20041229232028.055f8786.akpm@osdl.org>
In-Reply-To: <4d8e3fd304122923127167067c@mail.gmail.com>
References: <m3mzw262cu.fsf@rajsekar.pc>
	<41CD51E6.1070105@kolivas.org>
	<04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak>
	<41D31373.1090801@kolivas.org>
	<4d8e3fd304122914466b42c632@mail.gmail.com>
	<41D33603.9060501@kolivas.org>
	<4d8e3fd304122923127167067c@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>
> Andrew, 
>  what's your plan for the staircase scheduler ?

I have none, frankly.  I haven't seen any complaints about the current
scheduler.

If someone can identify bad behaviour in the current scheduler which
staircase improves then please describe a tescase which the scheduler
developers can use to reproduce the situation.

If, after that, we deem that the problem cannot be feasibly fixed within the
context of the current scheduler and that the problem is sufficiently
serious to justify wholesale replacement of the scheduler then sure,
staircase is an option.

