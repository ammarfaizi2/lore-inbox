Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTKTHsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 02:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTKTHsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 02:48:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:28891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264256AbTKTHsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 02:48:32 -0500
Date: Wed, 19 Nov 2003 23:53:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: torvalds@osdl.org, zwane@arm.linux.org.uk, mingo@elte.hu,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       hugh@veritas.com
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
Message-Id: <20031119235359.37133797.akpm@osdl.org>
In-Reply-To: <20031120074405.GG22139@waste.org>
References: <Pine.LNX.4.53.0311181113150.11537@montezuma.fsmlabs.com>
	<Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org>
	<20031119203210.GC22139@waste.org>
	<20031119230928.GE22139@waste.org>
	<20031120074405.GG22139@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
>  -	load_esp0(tss, &tsk->thread);
>  +	load_virtual_esp0(tss, tsk);

Thanks guys.

Now I'll have to put something else in there to keep you amused ;)


