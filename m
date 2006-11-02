Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWKBR7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWKBR7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWKBR7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:59:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1222 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751256AbWKBR7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:59:13 -0500
Subject: Re: Can Linux live without DMA zone?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
In-Reply-To: <454A1D82.7040709@cfl.rr.com>
References: <20061102021547.GA1240@srv.junsun.net>
	 <454A1D82.7040709@cfl.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Nov 2006 18:02:54 +0000
Message-Id: <1162490574.11965.224.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-02 am 11:32 -0500, ysgrifennodd Phillip Susi:
> Shouldn't only ancient ISA drivers be using GFP_DMA?  You know, ones 
> that actually require it?  PCI drivers should not have this limit.

"Should" and "Do not" are different things. Many PCI drivers have
interesting little limits.

