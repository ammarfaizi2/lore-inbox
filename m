Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270062AbTGNP1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbTGNP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:26:34 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:62700
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270062AbTGNPZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:25:18 -0400
Date: Mon, 14 Jul 2003 11:40:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Lars Duesing <ld@stud.fh-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: include/linux/pci.h inconsistency?
Message-ID: <20030714154006.GA20850@gtf.org>
References: <1058195165.4131.6.camel@ws1.intern.stud.fh-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058195165.4131.6.camel@ws1.intern.stud.fh-muenchen.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 05:06:06PM +0200, Lars Duesing wrote:
> btw: this driver_data is used by the networking part of the
> nforce2-driver. If anybody knows a hint, tell me. 

If nVidia had a clue, they would have used the portability wrappers
created specifically for this purpose:  pci_{get,dev}_drvdata.  This
works in 2.4, 2.5, and with the kcompat[1] toolkit, 2.2 also.


> Else I will try to wake up someone at nvidia.

Wake up someone at nVidia and get them to work with open source
net drivers.

I bet it works with amd8111e.c with a little modification, for example.

	Jeff



[1] http://sf.net/projects/gkernel/

