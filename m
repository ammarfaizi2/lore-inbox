Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbSLLMCm>; Thu, 12 Dec 2002 07:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLLMCm>; Thu, 12 Dec 2002 07:02:42 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:40133
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267458AbSLLMCk>; Thu, 12 Dec 2002 07:02:40 -0500
Subject: Re: [BK PATCH] Dynamic MP_BUSSES and IRQ_SOURCES for 2.4.21-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021212015326.GI16615@kroah.com>
References: <20021212015326.GI16615@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 12:48:08 +0000
Message-Id: <1039697288.21192.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 01:53, Greg KH wrote:
> If the machine needs more busses or interrupts, they will be dynamically
> allocated at boot time.  If not, the existing MAX_MP_BUSSES and
> MAX_IRW_SOURCES value will be used.  Once nice side effect of this patch
> is when running a SMP kernel on a UP machine without a MP table, less
> kernel memory is used than without the patch.
>   
> This patch was originally written by James Cleverdon, and has been in
> the -ac tree for quite some time.  I also think Red Hat includes it in
> their main kernel, but am not sure.

Its certainly been in some of our trees.

Marcelo this patch hasn't caused any problem reports in -ac for a long
time. I'm all for including it.

