Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbUAUJ2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 04:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAUJ2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 04:28:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:19075 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265881AbUAUJ2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 04:28:39 -0500
Date: Wed, 21 Jan 2004 01:29:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: gcs@lsc.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly ipv6 related
Message-Id: <20040121012903.04c82fde.akpm@osdl.org>
In-Reply-To: <400E47CB.5030000@aitel.hist.no>
References: <20040120000535.7fb8e683.akpm@osdl.org>
	<400D083F.6080907@aitel.hist.no>
	<20040120175408.GA12805@lsc.hu>
	<20040120102302.47fa26cd.akpm@osdl.org>
	<400E47CB.5030000@aitel.hist.no>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> Andrew Morton wrote:
> > GCS <gcs@lsc.hu> wrote:
> > 
> >>Offtopic ps:Sorry that I can not help further now, I kicked a door too
> >> badly that I think I broke my little finger on my leg. :-( But it would
> >> worth to try without CONFIG_REGPARM as Helge noted he has it turned on,
> >> and at least I also have it as Y.
> [...]
> > So yes, whatever compiler you are using, turn off CONFIG_REGPARM - it is
> > still very experimental.
> 
> I turned it off, and turned on debugging for stack and memory allocations.
> It still crashes at boot time, in a slightly different way.
> I got an "endless" amount of
> [<c011f202>] register_proc_table+0xc0/0xd6
> scrolling by at high speed.  After a minute or so it ended with
> addr_conf_init
> inet6_init

This should be fixed in 2.6.2-rc1.

