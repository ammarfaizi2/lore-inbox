Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVHAAk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVHAAk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVHAAjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:39:02 -0400
Received: from [81.2.110.250] ([81.2.110.250]:27284 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262297AbVHAAib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:38:31 -0400
Subject: Re: inter_module_get and __symbol_get
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "D. ShadowWolf" <dhazelton@enter.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200507310027.18484.dhazelton@enter.net>
References: <200507310027.18484.dhazelton@enter.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 01 Aug 2005 02:04:06 +0100
Message-Id: <1122858246.15622.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-07-31 at 00:27 -0400, D. ShadowWolf wrote:
> On this topic I have to weigh in that I just subscribed to the kernel list 
> because I have had to undo a modification made to the kernel around version 
> 2.6.10 that stopped the export of 'inter_module_get'.  To me it appears that 
> some kernel developers forget that there are those of us out there who do not 
> have broadband connections and are shafted with low-end hardware.

inter_module_* are going away. It was always a badly designed interface
and the new module code no longer requires it. 

Alan


