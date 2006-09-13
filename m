Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWIMSeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWIMSeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWIMSeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:34:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52109 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751046AbWIMSeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:34:10 -0400
Date: Wed, 13 Sep 2006 14:30:52 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] AVR32: Make PROT_WRITE | PROT_EXEC imply PROT_READ
In-Reply-To: <20060913100500.4e41ef8e@cad-250-152.norway.atmel.com>
Message-ID: <Pine.LNX.4.64.0609131429540.5326@dhcp83-20.boston.redhat.com>
References: <20060913100500.4e41ef8e@cad-250-152.norway.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2006, Haavard Skinnemoen wrote:

> The AVR32 MMU has three protection bits for allowing unprivileged
> access, write access and execute access respectively. There is no
> way to deny read access while allowing write or execute access.
> 
> make-prot_write-imply-prot_read.patch in mm does basically the same
> thing for several other architectures. One important difference is
> that this patch makes PROT_EXEC imply PROT_READ as well, but it looks
> like this is the case for most other architectures already.
> 

makes sense to me.

Acked-by: Jason Baron <jbaron@redhat.com>


