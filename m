Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423231AbWJTUZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423231AbWJTUZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423141AbWJTUZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:25:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422820AbWJTUZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:25:36 -0400
Date: Fri, 20 Oct 2006 13:25:32 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020132532.65a3e655@dxpl.pdx.osdl.net>
In-Reply-To: <20061020.125226.59656580.davem@davemloft.net>
References: <20061020081857.743b5eb7@localhost.localdomain>
	<20061020.122427.55507415.davem@davemloft.net>
	<20061020122527.56292b56@dxpl.pdx.osdl.net>
	<20061020.125226.59656580.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 12:52:26 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Fri, 20 Oct 2006 12:25:27 -0700
> 
> > Sorry, but why should we treat out-of-tree vendor code any
> > differently than out-of-tree other code.
> 
> I think what netdump was trying to do, provide a way to
> requeue instead of fully drop the SKB, is quite reasonable.
> Don't you think?


Netdump doesn't even exist in the current Fedora source rpm.
I think Dave dropped it.
