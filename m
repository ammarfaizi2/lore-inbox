Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270081AbTGPCXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 22:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270079AbTGPCXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 22:23:11 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:8679 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id S270070AbTGPCXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 22:23:08 -0400
Date: Tue, 15 Jul 2003 19:37:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Shih <alan@storlinksemi.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-ID: <20030715193758.C8616@home.com>
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com> <20030713004818.4f1895be.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030713004818.4f1895be.davem@redhat.com>; from davem@redhat.com on Sun, Jul 13, 2003 at 12:48:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 12:48:18AM -0700, David S. Miller wrote:
> On receive side, clever RX buffer flipping tricks are the way
> to go and require no protocol changes and nothing gross like
> TOE or weird buffer ownership protocols like RDMA requires.
> 
> I've made postings showing how such a scheme can work using a limited
> flow cache on the networking card.  I don't have a reference handy,
> but I suppose someone else does.

The following reference should be useful for those following along
at home and wondering what the hell this hardware flow cache scheme
is:

http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/0429.html

Regards,
-- 
Matt Porter
mporter@kernel.crashing.org
