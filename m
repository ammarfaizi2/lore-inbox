Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTL3GST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 01:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTL3GSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 01:18:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11979 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264446AbTL3GSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 01:18:15 -0500
Date: Mon, 29 Dec 2003 22:13:45 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-Id: <20031229221345.31c8c763.davem@redhat.com>
In-Reply-To: <3FF11745.4060705@pobox.com>
References: <1072567054.4112.14.camel@gaston>
	<20031227170755.4990419b.davem@redhat.com>
	<3FF0FA6A.8000904@pobox.com>
	<20031229205157.4c631f28.davem@redhat.com>
	<20031230051519.GA6916@gtf.org>
	<20031229220122.30078657.davem@redhat.com>
	<3FF11745.4060705@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003 01:12:21 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Think about the name of this function:  dev_kfree_skb_any()
> 
> If this function cannot be used -anywhere-, then the concept (and the 
> net stack) is fundamentally broken for this function.  We must _remove_ 
> the function, and thus _I_ have a lot of driver work to do.

If it makes you happy, change the suffix of the name, I am
not emotionally attached to the name.
