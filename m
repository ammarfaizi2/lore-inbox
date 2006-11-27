Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWK0S20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWK0S20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWK0S20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:28:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932313AbWK0S2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:28:25 -0500
Date: Mon, 27 Nov 2006 10:24:55 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1: drivers/net/chelsio/: unused code
Message-ID: <20061127102455.362fe88f@dxpl.pdx.osdl.net>
In-Reply-To: <20061124001731.GO3557@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
	<20061124001731.GO3557@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 01:17:31 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-rc5-mm2:
> >...
> > +chelsio-22-driver.patch
> >...
> >  netdev updates
> 
> It is suspicious that the following newly added code is completely unused:
>   drivers/net/chelsio/ixf1010.o
>     t1_ixf1010_ops
>   drivers/net/chelsio/mac.o
>     t1_chelsio_mac_ops
>   drivers/net/chelsio/vsc8244.o
>     t1_vsc8244_ops
> 
> cu
> Adrian
> 

All that is gone in later version. I reposted new patches
after -mm2 was done.
