Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992730AbWJTTZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992730AbWJTTZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992726AbWJTTZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:25:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992709AbWJTTZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:25:33 -0400
Date: Fri, 20 Oct 2006 12:25:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020122527.56292b56@dxpl.pdx.osdl.net>
In-Reply-To: <20061020.122427.55507415.davem@davemloft.net>
References: <20061019171814.281988608@osdl.org>
	<20061020.001530.35664340.davem@davemloft.net>
	<20061020081857.743b5eb7@localhost.localdomain>
	<20061020.122427.55507415.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 12:24:27 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Fri, 20 Oct 2006 08:18:57 -0700
> 
> > Netdump is not in the tree, so I can't fix it. Also netdump is pretty
> > much superseded by kdump.
> 
> Unless kdump is %100 ready you can be sure vendors will ship netdump
> for a little while longer.  I think gratuitously breaking netdump is
> not the best idea.
> 
> It's not like netdump is some binary blob you can't get the source
> to easily. :-)
> 

Sorry, but why should we treat out-of-tree vendor code any differently
than out-of-tree other code.
