Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271176AbUJVB51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271176AbUJVB51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271119AbUJVB4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:56:32 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:22987 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S271087AbUJVBt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:49:27 -0400
Date: Thu, 21 Oct 2004 18:33:22 -0700 (PDT)
From: <akepner@sgi.com>
X-X-Sender: <akepner@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "David S. Miller" <davem@davemloft.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>, <gnb@sgi.com>
Subject: Re: [PATCH] use mmiowb in tg3.c
In-Reply-To: <1098407804.6071.22.camel@gaston>
Message-ID: <Pine.LNX.4.33.0410211826480.392-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Benjamin Herrenschmidt wrote:

> ... 
> Typically, our normal "light" write barrier doesn't reorder between cacheable
> and non-cacheable (MMIO) stores, which is why we had to put some heavy sync
> barrier in our MMIO writes macros.
> ...

Do you mean "impose order" rather than "reorder" here? 

-- 
Arthur



