Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWBMXGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWBMXGB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWBMXGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:06:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030256AbWBMXGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:06:00 -0500
Date: Mon, 13 Feb 2006 15:04:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: lkml@rtr.ca, dgc@sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: dirty pages (Was: Re: [PATCH] Prevent large file writeback
 starvation)
Message-Id: <20060213150457.547ddfb4.akpm@osdl.org>
In-Reply-To: <20060213224835.GC5565@linuxtv.org>
References: <20060206040027.GI43335175@melbourne.sgi.com>
	<20060205202733.48a02dbe.akpm@osdl.org>
	<43E75ED4.809@rtr.ca>
	<43E75FB6.2040203@rtr.ca>
	<20060206121133.4ef589af.akpm@osdl.org>
	<20060213135925.GA6173@linuxtv.org>
	<20060213120847.79215432.akpm@osdl.org>
	<20060213224835.GC5565@linuxtv.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@linuxtv.org> wrote:
>
> On Mon, Feb 13, 2006, Andrew Morton wrote:
>  > Johannes Stezenbach <js@linuxtv.org> wrote:
>  > > Now copying a 700MB file makes "Dirty" go up to 350MB. It then
>  > > slowly decreases to 325MB and stays there.
>  > 
>  > It shouldn't.  Did you really leave it for long enough?
>  > 
>  > If you did, then why does it happen there and not here?
> 
>  Good question. I just repeated the execise, rebooted and
>  copied a 700MB file. After ~30min "Dirty" is down to ~130MB, and
>  continues to decrease very slowly.
> 
>  On my Desktop machine (P4 HT, 1G RAM) "Dirty" goes down near
>  zero after ~30sec, as expected.

Are you using any unusual mount options?

Which filesystem types are online (not that this should affect it...)
