Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUEENDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUEENDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUEENDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:03:13 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:32433 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264652AbUEEM6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:58:25 -0400
Date: Wed, 5 May 2004 14:58:23 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
In-Reply-To: <200405052214.38855.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0405051449390.17257@jurand.ds.pg.gda.pl>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com>
 <200405040111.01514.bzolnier@elka.pw.edu.pl> <200405052214.38855.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2004, Ross Dickson wrote:

> We need it off for nforce2 to get nmi_watchdog=1 working with ioapic
> 8254 timer pin0  timer override patch routing. I vote to revisit Maciej's
> patch that was dropped by Linus after appearing in 2.6.3-mm3. 
> For those with problems of clock skew with the timer into pin0 routing, 
> that patch gave a virtual wire timer routing which worked well for those
> users.
> 
> It also works around problems for ibm users.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/4421.html
> 
> That patch is last posted here (Maciej please correct me if i'm wrong)
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/3174.html

 That's my latest version, although the one in -mm had a minor readability 
improvement, so you may use that one instead.

 BTW, can you please check if the chipset fixup cures the timer IRQ line
noise?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
