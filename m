Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSJVXXk>; Tue, 22 Oct 2002 19:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbSJVXXk>; Tue, 22 Oct 2002 19:23:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41482 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262506AbSJVXXk>;
	Tue, 22 Oct 2002 19:23:40 -0400
Message-ID: <3DB5DF63.6000000@pobox.com>
Date: Tue, 22 Oct 2002 19:29:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@rth.ninka.net>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
       Slavcho Nikolov <snikolov@okena.com>, linux-kernel@vger.kernel.org
Subject: Re: feature request - why not make netif_rx() a pointer?
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K> 	<20021022211535.GZ1111@mea-ext.zmailer.org> <1035326559.16085.18.camel@rth.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 2002-10-22 at 14:15, Matti Aarnio wrote:
> 
>>  ftp://zmailer.org/linux/netif_rx.patch
> 
> 
> Please EXPORT_GPL this, if you are going to do it at all.



ug :(   Can we please have this not be in the fast path.  Thanks.

Make netif_rx_ the pointer, don't slow down my net drivers further...

	Jeff



