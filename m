Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275492AbTHMVXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275500AbTHMVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:23:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40136 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275492AbTHMVXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:23:44 -0400
Date: Wed, 13 Aug 2003 14:17:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: greg@kroah.com, jgarzik@pobox.com, rddunlap@osdl.org, davej@redhat.com,
       willy@debian.org, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-Id: <20030813141707.6f834825.davem@redhat.com>
In-Reply-To: <m31xvpe2ar.fsf@defiant.pm.waw.pl>
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
	<m31xvpe2ar.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Aug 2003 22:21:48 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> We might even consider
> 
> +	{ PCI_DEVICE(BROADCOM, TIGON3_5700) },
> +	{ PCI_DEVICE(BROADCOM, TIGON3_5701) },
> 

I personally don't like that, that breaks grepping.
