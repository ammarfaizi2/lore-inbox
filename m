Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275284AbTHMRmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275285AbTHMRmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:42:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1479 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275284AbTHMRmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:42:49 -0400
Date: Wed, 13 Aug 2003 10:36:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-Id: <20030813103644.3bf9de67.davem@redhat.com>
In-Reply-To: <20030813173150.GA3317@kroah.com>
References: <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
	<20030812180158.GA1416@kroah.com>
	<3F397FFB.9090601@pobox.com>
	<20030812171407.09f31455.rddunlap@osdl.org>
	<3F3986ED.1050206@pobox.com>
	<20030812173742.6e17f7d7.rddunlap@osdl.org>
	<20030813004941.GD2184@redhat.com>
	<32835.4.4.25.4.1060743746.squirrel@www.osdl.org>
	<3F39AFDF.1020905@pobox.com>
	<20030813031432.22b6a0d6.davem@redhat.com>
	<20030813173150.GA3317@kroah.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 10:31:51 -0700
Greg KH <greg@kroah.com> wrote:

> How about this patch?
...
> +#define PCI_DEVICE(vend,dev) \
> +	.vendor = (vend), .device = (dev), \
> +	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID

Looks fine to me.
