Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTIONpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbTIONpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:45:31 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:58786 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261336AbTIONpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:45:30 -0400
Subject: Re: [PATCH] Fix IDE compile on PPC in 2.4.23-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16229.45091.906515.365451@nanango.paulus.ozlabs.org>
References: <16229.45091.906515.365451@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063633399.3734.15.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 14:43:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 13:27, Paul Mackerras wrote:
> Marcelo & Bart,
> 
> Currently, the IDE code in 2.4.23-pre4 does not compile on PPC because
> of a missed symbol name change in drivers/ide/ide-probe.c.  This
> instance got missed because it is in a #ifdef CONFIG_PPC section.
> 
> The patch below fixes it.  Please apply.

Definitely right..


