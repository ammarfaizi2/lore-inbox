Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267857AbTB1MNH>; Fri, 28 Feb 2003 07:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267858AbTB1MNH>; Fri, 28 Feb 2003 07:13:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:29592 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267857AbTB1MNG>;
	Fri, 28 Feb 2003 07:13:06 -0500
Date: Fri, 28 Feb 2003 04:24:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: steven roemen <sdroemen1@cox.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.63-mm1
Message-Id: <20030228042417.38dd9e80.akpm@digeo.com>
In-Reply-To: <1046434612.4418.5.camel@lws04.home.net>
References: <20030227025900.1205425a.akpm@digeo.com>
	<1046434612.4418.5.camel@lws04.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 12:23:20.0284 (UTC) FILETIME=[2DF801C0:01C2DF24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steven roemen <sdroemen1@cox.net> wrote:
>
> 
> the kernel oopses when i2c is compiled into the kernel with -mm1, and
> -mm1 with dave mccraken's patch.  

Please send a full report on this to the mailing list.

> also when i remove i2c from the kernel and boot into it with AS as the
> elevator, the load (via top) starts at 2.00, yet the processors aren't
> loaded very much at all.  is this a known issue(this is the first -mm
> kernel i've run)?

Run `ps aux' when the system is idle and see if there are any tasks
in "D" state.

