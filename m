Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269593AbUI3WEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269593AbUI3WEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269582AbUI3WD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:03:59 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:23502 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269535AbUI3WDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:03:44 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Date: Fri, 1 Oct 2004 00:01:27 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040930184535.GA31197@devserv.devel.redhat.com> <200409302245.18866.bzolnier@elka.pw.edu.pl> <20040930213500.GC2175@devserv.devel.redhat.com>
In-Reply-To: <20040930213500.GC2175@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410010001.27607.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 23:35, Alan Cox wrote:
> On Thu, Sep 30, 2004 at 10:45:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > - merge+describe needed IDE core changes
> 
> Happily. I'm of the opinion the "ident whacking" callback isnt justified,
> only one driver has a need for it and that driver can do it in the iops hook.

ok, you are right

> > - fix coding style and whitespace damage
> 
> Yeah
> 
> > - kill useless DECLARE_ITE_DEV macro
> 
> I'd prefer to keep it (there are likely to be some related devices from
> the databook)

you can add it when needed

> > - add __init to it8212_ide_init()
> 
> Good point - will fix

thanks
