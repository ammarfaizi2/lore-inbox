Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263842AbUDVNWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUDVNWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUDVNWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:22:43 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:60313 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263842AbUDVNWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:22:42 -0400
Date: Thu, 22 Apr 2004 15:22:40 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Jamie Lokier <jamie@shareable.org>, Allen Martin <AMartin@nvidia.com>,
       ross@datscreative.com.au,
       Christian =?ISO-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH]
In-Reply-To: <1082606439.16333.188.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0404221414470.16448@jurand.ds.pg.gda.pl>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
  <1082058625.24423.161.camel@dhcppc4>  <20040416082730.GB22226@mail.shareable.org>
 <1082606439.16333.188.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Len Brown wrote:

> So if
> 1. all nforce2 chipsets have timer connected to pin0

 Allen, is there a possibility to get a clarification from Nvidia on that?  
Specifically, assuming both an 8254 and an I/O APIC core are integrated
into the chip, whether OUT0 of the 8254 is unconditionally routed to
INTIN0 of the I/O APIC or is it configurable somehow.

> 2. we can safely discover we're on nforce2 early enough,
>    like andi did on x86_64
> 
> then we could apply the workaround automatically always
> w/o any harm.

 Indeed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
