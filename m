Return-Path: <linux-kernel-owner+w=401wt.eu-S1754169AbWL0JEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbWL0JEP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 04:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbWL0JEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 04:04:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33165 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbWL0JEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 04:04:13 -0500
Subject: Re: [PATCH 1/10] cxgb3 - main header files
From: Arjan van de Ven <arjan@infradead.org>
To: Divy Le Ray <divy@chelsio.com>
Cc: Jeff Garzik <jeff@garzik.org>, Divy Le Ray <None@chelsio.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
In-Reply-To: <45923432.9040607@chelsio.com>
References: <20061220124125.6286.17148.stgit@localhost.localdomain>
	 <45918CA4.3020601@garzik.org>  <45923432.9040607@chelsio.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 10:03:57 +0100
Message-Id: <1167210238.3281.3751.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 00:52 -0800, Divy Le Ray wrote:
> Jeff,
> 
> You can grab the monolithic patch at this URL:
> http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
> 
> This patch adds support for the latest 1G/10G Chelsio adapter, T3.
> It is required by the T3 RDMA driver Steve Wise submitted.


does this patch still contain all the private ioctls?
They are being ripped out from another new driver, and cxgb3 should
probably have the same treatment...


