Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUCaLNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 06:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUCaLNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 06:13:05 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:17113 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261907AbUCaLNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 06:13:01 -0500
Date: Wed, 31 Mar 2004 13:13:00 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Len Brown <len.brown@intel.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
In-Reply-To: <4069D3D2.2020402@tmr.com>
Message-ID: <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
References: <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4>
 <4069D3D2.2020402@tmr.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Bill Davidsen wrote:

> Is there no reasonable way to avoid using it in ACPI? It's not as if 
> performance was critical there, or the code gets run often. Too bad it 
> can't just be emulated like floating point, but I don't think it can on SMP.

 Well, "cmpxchg", "xadd", etc. can be easily emulated with an aid of a
spinlock.  With SMP operation included.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
