Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275284AbTHGLsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275286AbTHGLsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:48:33 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:40834 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275284AbTHGLsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:48:32 -0400
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mitch@0Bits.COM
Cc: Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.53.0308061521430.22986@mx.homelinux.com>
References: <Pine.LNX.4.53.0308061521430.22986@mx.homelinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 12:44:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-06 at 15:38, Mitch@0Bits.COM wrote:
> I think with the new vmap changes that went in in -pre7 means
> you will need to get a new drm module (like from X cvs or
> http://dri.sourceforge.net/downloads.phtml) and recompile it
> with the new kernel headers which will then pick up the define
> -DVMAP_4_ARGS in the Makefile and give you a good module that works.
> 
> The DRI kernel trees need updating.

That doesn't seem a 2.4.22 candidate thing to me. If vmap broke the DRI
then the vmap patch wants reverting for 2.4.22 IMHO, and looking at for
2.4.23.

