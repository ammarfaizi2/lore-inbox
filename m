Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTILW36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTILW36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:29:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:38041 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261875AbTILW34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:29:56 -0400
Subject: Re: SII SATA request size limit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309121800.34765.eu@marcelopenna.org>
References: <200309121800.34765.eu@marcelopenna.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063405713.5783.16.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 23:28:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 22:00, Marcelo Penna Guerra wrote:
>      * Rev. <= 0x01 of the 3112 have a bug that can cause data 
>      * corruption if DMA transfers cross an 8K boundary.  This is 
>      * apparently hard to tickle, but we'll go ahead and play it 
>      * safe. 

It isnt that simple, unfortunately you need an NDA for the full story.
If you want to check which chips need it get a setup that hangs reliably
with large transfers, put the same disks on a newer controller that
doesnt and see what happens

