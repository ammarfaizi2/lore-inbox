Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264146AbUDVPkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbUDVPkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbUDVPks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:40:48 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:22488 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264146AbUDVPkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:40:47 -0400
Date: Thu, 22 Apr 2004 17:40:45 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Christian =?ISO-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Allen Martin <AMartin@nvidia.com>, ross@datscreative.com.au,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH]
In-Reply-To: <1082647660.16337.243.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0404221736530.16448@jurand.ds.pg.gda.pl>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
  <1082606439.16333.188.camel@dhcppc4>  <Pine.LNX.4.55.0404221414470.16448@jurand.ds.pg.gda.pl>
  <200404221553.51585.christian.kroener@tu-harburg.de> <1082647660.16337.243.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Len Brown wrote:

> Yes, this is normal on ACPI+IOAPIC configs going forward
> details here:  http://bugzilla.kernel.org/show_bug.cgi?id=2564

 Except that the IRQ was reserved for plain 8259A setups, where it is
really used for a cascade for a slave 8259A, long before any APIC support
was there in Linux.  JFTR.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
