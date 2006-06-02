Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWFBXuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWFBXuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 19:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWFBXuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 19:50:03 -0400
Received: from a34-mta02.direcpc.com ([66.82.4.91]:13601 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751051AbWFBXuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 19:50:01 -0400
Date: Fri, 02 Jun 2006 19:49:31 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 2.6.17-rc5-mm2 17/18] sbp2: provide	helptext	for
	CONFIG_IEEE1394_SBP2_PHYS_DMA and mark it experimental
In-reply-to: <4480C7F4.907@s5r6.in-berlin.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Message-id: <1149292171.4533.330.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
 <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
 <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
 <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
 <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de>
 <tkrat.96e1b392429fe277@s5r6.in-berlin.de>
 <tkrat.df90273c07dd7503@s5r6.in-berlin.de> <1149281162.4533.304.camel@grayson>
 <4480B45E.4060909@s5r6.in-berlin.de> <1149286809.4533.319.camel@grayson>
 <4480C7F4.907@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 01:21 +0200, Stefan Richter wrote:
> Ben Collins wrote:
> > Rather it be in the config. Plus your suggestion still makes it
> > unusable :)
> 
> Right. But only if ohci1394 is loaded with phys_dma=0 or a controller 
> without phys DMA is used. Only these conditions let sbp2 run into the 
> routine which currently uses bus_to_virt.

Sure, that's not a problem. I just don't think we should make the option
available on platforms where it cannot work at all. No need to add to
the confusion.

> Would '&& (X86_32 || PPC_32)' work too?

Perfect.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

