Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272393AbTHNPJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272395AbTHNPJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:09:35 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60034 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272393AbTHNPJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:09:34 -0400
Subject: Re: 2.4.22-rc, IDE: cannot unload piix module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Urs Thuermann <urs@isnogud.escape.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m2k79gxqan.fsf@isnogud.escape.de>
References: <m2k79gxqan.fsf@isnogud.escape.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060873759.5983.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 14 Aug 2003 16:09:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 15:33, Urs Thuermann wrote:
> After loading the module piix.o for some Intel IDE chips, the usage
> count is 1 even if the module isn't used, so the module cannot be
> unloaded.

The 2.4.x IDE doesnt support modular unload

