Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946139AbWJTDZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946139AbWJTDZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWJTDZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:25:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:23743 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751652AbWJTDZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:25:37 -0400
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Nicolas DET <nd@bplan-gmbh.de>, linuxppc-dev@ozlabs.org,
       Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20061020114749.fe7b71d6.sfr@canb.auug.org.au>
References: <20061019122802.GA26637@aepfle.de>
	 <45377ED3.9030001@bplan-gmbh.de>
	 <1161308221.10524.92.camel@localhost.localdomain>
	 <20061020114749.fe7b71d6.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 13:24:45 +1000
Message-Id: <1161314685.10524.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Surely it doesn't need exporting is its only caller is in
> arch/powerpc/platforms/chrp/setup.c?

Today... I can see reasons why platform drivers might want to get at
it, but I can remove the export for now.

Ben.


