Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbUJZJTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbUJZJTC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbUJZJTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:19:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:47493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262181AbUJZJS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:18:59 -0400
Date: Tue, 26 Oct 2004 02:16:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: cw@f00f.org, yi.zhu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [swsusp] print error message when swapping is disabled
 (fwd)
Message-Id: <20041026021656.6d499fc8.akpm@osdl.org>
In-Reply-To: <20041026091449.GA28897@elf.ucw.cz>
References: <Pine.LNX.4.44.0410260949340.18363-100000@mazda.sh.intel.com>
	<20041026023858.GA7467@taniwha.stupidest.org>
	<20041026091449.GA28897@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > > +	if ((error = swsusp_swap_check())) {
>  > > +		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
>  > > +				"swapon -a!\n");
>  > 
>  > maybe it's just me, but i would really prefer to have the occasional
>  > long(er) line that splitting strings like that
> 
>  It is not just you :-).

Try looking at that long line in an 80-col xterm.  It looks worse than it
does with the manual break.

