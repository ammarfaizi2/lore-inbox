Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUEQWcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUEQWcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUEQWbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:31:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:62889 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263000AbUEQW0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:26:24 -0400
Date: Mon, 17 May 2004 15:29:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange problems with hanging sync
Message-Id: <20040517152900.2299b32b.akpm@osdl.org>
In-Reply-To: <20040517151325.GA27155@atrey.karlin.mff.cuni.cz>
References: <20040517151325.GA27155@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> 2.6.5 kernel. I did some pretty long and very disk intensive
> lingvistics job, then ^Z stopped it, and ran sync. sync was not
> returning for few minutes, I ran second one but it hang too. I ran
> second sync, but it appeared hanged too. I told lingvistics job to
> quit early, and then both syncs finished. Anyone seen something
> similar?
> 								Pavel
> -- 
> Horseback riding is like software...
> ...vgf orggre jura vgf serr.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

sysrq-T traces, please...
