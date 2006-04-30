Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWD3PuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWD3PuT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 11:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWD3PuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 11:50:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64930 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751155AbWD3PuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 11:50:17 -0400
Subject: Re: How to replace bus_to_virt()?
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <4454CF35.7010803@s5r6.in-berlin.de>
References: <4454CF35.7010803@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 17:50:14 +0200
Message-Id: <1146412215.20760.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 16:52 +0200, Stefan Richter wrote:
> Hi all,
> 
> is there a *direct* future-proof replacement for bus_to_virt()?
> 
> It appears there are already architectures which do not define a 
> bus_to_virt() funtion or macro. If there isn't a direct replacement, is 
> there at least a way to detect at compile time whether bus_to_virt() exists?

I'd go one step further: given a world with iommu's, and multiple pci
domains etc, how can you know there even IS such a translation possible
(without first having set it up from the other direction)?


