Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUI2Aor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUI2Aor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUI2Aor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:44:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:905 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267649AbUI2Aoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:44:46 -0400
Subject: Re: Reg IDE Driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sudhakar <v.sudhakar@gdatech.co.in>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409281646.25005.v.sudhakar@gdatech.co.in>
References: <200409281646.25005.v.sudhakar@gdatech.co.in>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096408613.14082.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Sep 2004 22:56:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-28 at 12:16, Sudhakar wrote:
> Is the IDE driver in the kernel is generic ?

Fairly

> Whether it can support CF Interfaces to a processor which has bo IDE 
> controller ?

Depends how it is connected

> For eg if a CF is connected to a local bus whether the ide driver in the 
> kernel can access it ?
> 
> If any modifications are needed,what are they ?

Take a look at something like ide_pnp.c, swap the PnP logic for however
you find your own CF device and try it.

