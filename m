Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271200AbUJVC3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271200AbUJVC3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271205AbUJVCN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:13:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:37553 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271179AbUJVCId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:08:33 -0400
Subject: Re: [PATCH] use mmiowb in tg3.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akepner@sgi.com
Cc: "David S. Miller" <davem@davemloft.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       Jeff Garzik <jgarzik@pobox.com>, gnb@sgi.com
In-Reply-To: <Pine.LNX.4.33.0410211826480.392-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0410211826480.392-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1098410843.6028.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 12:07:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 11:33, akepner@sgi.com wrote:
> On Fri, 22 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> > ... 
> > Typically, our normal "light" write barrier doesn't reorder between cacheable
> > and non-cacheable (MMIO) stores, which is why we had to put some heavy sync
> > barrier in our MMIO writes macros.
> > ...
> 
> Do you mean "impose order" rather than "reorder" here? 

Right.

Ben.


