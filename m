Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUIOIaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUIOIaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUIOIaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:30:21 -0400
Received: from karnickel.franken.de ([193.141.110.11]:12300 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S263806AbUIOIaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:30:14 -0400
Subject: Re: 2.6.9 rc2 freezing
From: Erik Tews <erik@debian.franken.de>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040913171649.GA24807@gemtek.lt>
References: <20040913165551.GA24135@gemtek.lt> <4145D4ED.6070403@pobox.com>
	 <20040913171649.GA24807@gemtek.lt>
Content-Type: text/plain
Message-Id: <1095236750.3960.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 10:25:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 13.09.2004 schrieb Zilvinas Valinskas um 19:16:
> On Mon, Sep 13, 2004 at 01:12:13PM -0400, Jeff Garzik wrote:
> > I'm totally blind, because I don't see your network driver in that big 
> > list of modules.
> > 
> > Your network driver should probably be doing dev_kfree_skb_any() 
> > somewhere, but isn't.
> > 
> > 	Jeff
> > 
> It is compiled in, see :
> 
> CONFIG_E100=y
> CONFIG_E100_NAPI=y
> 
> Can it be IPsec related ?

I got a similar problem here, I am running 2.6.9-rc2 with acpi patch. I
got an e1000, ipsec is compiled in, modules loaded, racoon started but
no tunnels configured.

The system freezes when I type apt-get update, in the moment apt-get
tries to connect all the mirrors or resolves them.

I did not see any messages, sysrq was not compiled in, so I cannot check
if it still works.

