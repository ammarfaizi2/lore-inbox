Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTDHJUP (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTDHJTa (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:19:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16792
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261283AbTDHJR2 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:17:28 -0400
Subject: Re: PATCH: clean up pci interrupt line whacking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E9209E9.1040208@gmx.net>
References: <200304080015.h380Fc34009018@hraefn.swansea.linux.org.uk>
	 <3E9209E9.1040208@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049755601.7143.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 23:46:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-08 at 00:29, Carl-Daniel Hailfinger wrote:
> Alan Cox wrote:
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/ide/pci/hpt366.c linux-2.5.67-ac1/drivers/ide/pci/hpt366.c
> > --- linux-2.5.67/drivers/ide/pci/hpt366.c	2003-03-26 19:59:51.000000000 +0000
> > +++ linux-2.5.67-ac1/drivers/ide/pci/hpt366.c	2003-04-06 23:03:51.000000000 +0100
> > @@ -1106,13 +1106,10 @@
> > [...]
> 
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/ide/pci/pdc202xx_new.c linux-2.5.67-ac1/drivers/ide/pci/pdc202xx_new.c
> > --- linux-2.5.67/drivers/ide/pci/pdc202xx_new.c	2003-03-26 19:59:51.000000000 +0000
> > +++ linux-2.5.67-ac1/drivers/ide/pci/pdc202xx_new.c	2003-04-06 23:04:50.000000000 +0100
> > @@ -592,15 +592,8 @@
> > [...]
> 
> Will this also go into 2.4.21?

Depends on 2.5 testing

