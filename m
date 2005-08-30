Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVH3OgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVH3OgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVH3OgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:36:17 -0400
Received: from embeddededge.com ([209.113.146.155]:29704 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S932157AbVH3OgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:36:17 -0400
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467302BEB8C6@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467302BEB8C6@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f208ac7cfaf2da5ada26a6dd91dc27b8@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       "Gala Kumar K.-galak" <kumar.gala@freescale.com>,
       linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] ppc32 :Added PCI support for MPC83xx
Date: Tue, 30 Aug 2005 10:36:00 -0400
To: Li Tony-r64360 <Tony.Li@freescale.com>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 29, 2005, at 11:02 PM, Li Tony-r64360 wrote:

> I think it is OK. The external interrupt can be edged. And it works 
> well in my board.

No, it can't.  PCI interrupts must be level sensitive because multiple
slots can share an interrupt.

Thanks.

	-- Dan

