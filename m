Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130775AbRBEQSx>; Mon, 5 Feb 2001 11:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135241AbRBEQSn>; Mon, 5 Feb 2001 11:18:43 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:56292 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135224AbRBEQSa>; Mon, 5 Feb 2001 11:18:30 -0500
Date: Mon, 5 Feb 2001 17:13:28 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Francois Romieu <romieu@cogenit.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1-ac1: W89c840 -- printout inconsistency?
In-Reply-To: <20010205155114.A13338@se1.cogenit.fr>
Message-ID: <Pine.GSO.3.96.1010205170740.18067Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Francois Romieu wrote:

> Wouldn't this ("work around broken '486 PCI boards") fit better in
> drivers/pci/quirks.c, somewhere around pci_fixup_device ?

 I thinks it's already in the right place.  The workaround is
driver-specific.  Only generic or bridge-specific code goes into
drivers/pci/quirks.c. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
