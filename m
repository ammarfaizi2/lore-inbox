Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWIKXL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWIKXL2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWIKXL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:11:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:61364 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965061AbWIKXL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:11:27 -0400
Subject: Re: [PATCH] Prevent legacy io access on pmac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060911151730.GA25244@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
	 <20060911151730.GA25244@aepfle.de>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:11:09 +1000
Message-Id: <1158016269.15465.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 17:17 +0200, Olaf Hering wrote:
> On Mon, Sep 11, Olaf Hering wrote:
> 
> > * add check for parport_pc, exit on pmac.
> 
> How do I allow parport on PCI cards?

Doesn't the driver have explicit PCI probing like 8250 ?

Ben.


