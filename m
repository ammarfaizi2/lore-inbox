Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWJPQiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWJPQiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964770AbWJPQiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:38:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64907 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964769AbWJPQix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:38:53 -0400
Subject: Re: [PATCH] pci: x86-32/64 switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061016162426.GB14354@muc.de>
References: <1161013892.24237.100.camel@localhost.localdomain>
	 <20061016160759.GA14354@muc.de>
	 <1161017113.24237.115.camel@localhost.localdomain>
	 <20061016162426.GB14354@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 18:05:40 +0100
Message-Id: <1161018340.24237.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 18:24 +0200, ysgrifennodd Andi Kleen:
> > You can't hot unplug your MMU
> 
> Not sure about that. Calgary is afaik in the bridges and since Summit
> has pluggable PCI cages and nodes i would assume the MMU instances are also
> hot pluggables.

If so Linux doesn't currently support that and the patch keeps things as
they are except for using hotplug safe APIs (and since I want to
exterminate pci_find_device* shortly thats preferable)

Alan

