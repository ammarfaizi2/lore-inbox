Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269534AbUI3Vf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269534AbUI3Vf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbUI3Vf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:35:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11746 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269518AbUI3VfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:35:17 -0400
Date: Thu, 30 Sep 2004 17:35:00 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Message-ID: <20040930213500.GC2175@devserv.devel.redhat.com>
References: <20040930184535.GA31197@devserv.devel.redhat.com> <200409302218.48115.bzolnier@elka.pw.edu.pl> <200409302245.18866.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409302245.18866.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 10:45:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> - merge+describe needed IDE core changes

Happily. I'm of the opinion the "ident whacking" callback isnt justified,
only one driver has a need for it and that driver can do it in the iops hook.

> - fix coding style and whitespace damage

Yeah

> - kill useless DECLARE_ITE_DEV macro

I'd prefer to keep it (there are likely to be some related devices from
the databook)

> - add __init to it8212_ide_init()

Good point - will fix

