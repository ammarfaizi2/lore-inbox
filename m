Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTH0ESx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 00:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTH0ESx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 00:18:53 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:64641
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263060AbTH0ESw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 00:18:52 -0400
Date: Wed, 27 Aug 2003 00:18:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
cc: support@stallion.oz.au, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 stallion serial driver cleanup
In-Reply-To: <16204.9419.975808.761408@wombat.disy.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.53.0308270015400.18494@montezuma.fsmlabs.com>
References: <16204.9419.975808.761408@wombat.disy.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Peter Chubb wrote:

> +		/* FIXME -- pass in a valid device id */
>  		if (request_irq(irq, stl_intr, SA_SHIRQ, name, NULL) != 0) {
>  			printk("STALLION: failed to register interrupt "
>  				"routine for %s irq=%d\n", name, irq);

You can't do SA_SHIRQ and none unique dev_id, please really do fix that.

Thanks,
	Zwane

