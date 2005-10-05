Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVJELXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVJELXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVJELXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:23:24 -0400
Received: from ozlabs.org ([203.10.76.45]:10889 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932619AbVJELXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:23:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17219.46319.501091.93202@cargo.ozlabs.ibm.com>
Date: Wed, 5 Oct 2005 21:11:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas <linas@austin.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ppc64: EEH typos, include files, macros, whitespace
In-Reply-To: <20050930005141.GA6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
	<20050930005141.GA6173@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas writes:

> 01-eeh-minor-cleanup.patch

Some trivial comments on a trivial patch... :)

> -		printk(KERN_WARNING "PCI: no pci dn found for dev=%s\n",
> -			pci_name(dev));
> +		printk(KERN_WARNING "PCI: no pci dn found for dev=%s\n", pci_name(dev));

This makes the line go over 80 columns, which seems unnecessary.

> - * @token i/o token, should be address in the form 0xE....
> + * @token i/o token, should be address in the form 0xA....

I think the virtual addresses we get from ioremap these days start
with 0xD00008...

Regards,
Paul.
