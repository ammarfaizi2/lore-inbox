Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269782AbUICUeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269782AbUICUeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUICUeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:34:13 -0400
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:54097 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269798AbUICUcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:32:18 -0400
Date: Fri, 3 Sep 2004 13:30:59 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Roland Dreier <roland@topspin.com>
Cc: Michael.Waychison@Sun.COM, plars@linuxtestproject.org,
       Brian.Somers@Sun.COM, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040903133059.483e98a0.davem@davemloft.net>
In-Reply-To: <52acw7rtrw.fsf@topspin.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com>
	<412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com>
	<412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com>
	<412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com>
	<52acw7rtrw.fsf@topspin.com>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2004 13:18:11 -0700
Roland Dreier <roland@topspin.com> wrote:

>     Paul> I tried this patch alone on top of 2.6.9-rc1 and tg3 is
>     Paul> still broken for me on JS20 blades.  Was there another patch
>     Paul> I should have applied in conjunction with this?
> 
> Me too -- I copied the latest BK tg3.c/tg3.h to my 2.6.8.1 tree and
> tried it on my JS20 and it didn't work.

What do you mean by "latest"?  If it doesn't indicate driver
version 3.9 it is not the latest.

Please make sure you try current sources, I've had nothing
but positive reports for IBM blades from people actually
using the correct current 3.9 driver.
