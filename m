Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbTFEMCB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbTFEMCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:02:00 -0400
Received: from ns.suse.de ([213.95.15.193]:43275 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264639AbTFEMB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:01:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: warren@togami.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 AMD64 dpt_i2o fails compile
References: <1054789161.3699.67.camel@laptop.suse.lists.linux.kernel>
	<20030605010841.A29837@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<1054799692.3699.77.camel@laptop.suse.lists.linux.kernel>
	<1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Jun 2003 14:15:24 +0200
In-Reply-To: <1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel>
Message-ID: <p73wug067qb.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Fixing up dpt_i2o for the new DMA stuff is a major job. Fixing it for
> 64bit cleanness even more so.

If the hardware/firmware supports 64bit pointers then at least AMD64
can work without the PCI DMA API. 

64bit cleanness is needed however.

-Andi
