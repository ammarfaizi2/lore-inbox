Return-Path: <linux-kernel-owner+w=401wt.eu-S965074AbXABXT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbXABXT6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbXABXT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:19:58 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39496
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965074AbXABXT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:19:57 -0500
Date: Tue, 02 Jan 2007 15:19:56 -0800 (PST)
Message-Id: <20070102.151956.15251307.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mm-commits@vger.kernel.org, m.kozlowski@tuxland.pl, jeff@garzik.org
Subject: Re: + net-ifb-error-path-loop-fix.patch added to -mm tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <200701022302.l02N2mQ9000440@shell0.pdx.osdl.net>
References: <200701022302.l02N2mQ9000440@shell0.pdx.osdl.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: akpm@osdl.org
Date: Tue, 02 Jan 2007 15:02:47 -0800

> 
> The patch titled
>      net: ifb error path loop fix
> has been added to the -mm tree.  Its filename is
>      net-ifb-error-path-loop-fix.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: net: ifb error path loop fix
> From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
> On error we should start freeing resources at [i-1] not [i-2].
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Please remove this patch, it's buggy :)
