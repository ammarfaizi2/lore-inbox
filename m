Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbTH2XVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 19:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTH2XVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 19:21:13 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:21171 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262167AbTH2XVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 19:21:10 -0400
Subject: Re: [PATCH] ymf724 oops in 2.4.22, boot fails
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: zaitcev@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4FBB78.8DD75F69@megsinet.net>
References: <3F4FBB78.8DD75F69@megsinet.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062199222.29839.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sat, 30 Aug 2003 00:20:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-29 at 21:45, M.H.VanLeeuwen wrote:
> Pete,
> 
> The attached patch allows my system to boot 2.4.22 successfully.
> 
> a. if the read of AC97_EXTENDED_ID fails just leave eid NULL and continue
>    to fix??? no codec attached.  Here is my dmesg output for this device:

I've already sent Marcelo a fix for this that also resolves the oops
case. See 2.4.22-ac1

 
