Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWFZPeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWFZPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWFZPeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:34:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17892 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932492AbWFZPeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:34:15 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060626151012.GR23314@stusta.de>
References: <20060626151012.GR23314@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 16:48:28 +0100
Message-Id: <1151336908.27147.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-26 am 17:10 +0200, ysgrifennodd Adrian Bunk:
> virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
> on i386.
> 
> Without such warnings people will never update their code and fix 
> the errors in PPC64 builds.

Most of the uses of virt_to_bus/bus_to_virt are hardware that isn't even
available on obscure platforms like PPC64. Would still be good to get
these in and nailed.


