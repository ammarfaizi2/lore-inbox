Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTJHN5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTJHN5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:57:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6865 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261460AbTJHN5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:57:30 -0400
Date: Wed, 8 Oct 2003 06:47:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: toby@cbcg.net, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, akpm@zip.com.au, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
Message-Id: <20031008064735.7373227b.davem@redhat.com>
In-Reply-To: <3F840C9C.9050704@pobox.com>
References: <1065617075.1514.29.camel@localhost>
	<3F840C9C.9050704@pobox.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Oct 2003 09:09:48 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> I would prefer that you fix your code instead, to not pass NULL to 
> kfree_skb()...

Absolutely, there is no valid reason to pass NULL into these
routines.
