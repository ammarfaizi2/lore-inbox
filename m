Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbTHUTkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbTHUTkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 15:40:53 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:18959 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262879AbTHUTkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 15:40:52 -0400
Date: Thu, 21 Aug 2003 21:42:00 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Christian Axelsson <smiler@lanil.mine.nu>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [2.6.0-test3-mm3] irda compile error
In-Reply-To: <3F44A22D.6040005@lanil.mine.nu>
Message-ID: <Pine.LNX.4.44.0308212120380.3006-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Christian Axelsson wrote:

> Got this while doing  make. Config attached.
> Same config compiles fine under mm2
> 
>  CC      drivers/net/irda/vlsi_ir.o
> drivers/net/irda/vlsi_ir.c: In function `vlsi_proc_pdev':
> drivers/net/irda/vlsi_ir.c:167: structure has no member named `name'

Yep, Thanks. I'm aware of the problem which is due to the recent 
device->name removal. In fact a fix for this was already included in the 
latest resent of my big vlsi update patch pending since long.

Anyway, it was pointed out now the patch is too big so I'm currently 
working on splitting it up. Bunch of patches will follow soon :-)

Btw., are you actually using this driver? I'm always looking for testers 
with 2.6 to give better real life coverage...

Martin

