Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbSJBWNi>; Wed, 2 Oct 2002 18:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbSJBWNi>; Wed, 2 Oct 2002 18:13:38 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51974
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262656AbSJBWNh>; Wed, 2 Oct 2002 18:13:37 -0400
Subject: Re: 2.4.20pre8aa2
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20021002214540.GA2589@werewolf.able.es>
References: <20021002071110.GC1158@dualathlon.random>
	 <20021002214540.GA2589@werewolf.able.es>
Content-Type: text/plain
Organization: 
Message-Id: <1033597107.27343.44.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 18:18:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 17:45, J.A. Magallon wrote:

> I was rediffing the task_cpu patch, when reached a new hunk in -aa:
> 
> kernel/sched.c::sched_init(void):
> 
> +   current->cpu = smp_processor_id();

Ew we do that in 2.5, too.

I think this is a mistake; we don't need to do this here.  But if I am
wrong, we need to get the current processor number elsewhere.

	Robert Love

