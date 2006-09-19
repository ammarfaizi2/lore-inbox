Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWISHkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWISHkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 03:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWISHkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 03:40:00 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:3757 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751142AbWISHj6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 03:39:58 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
Date: Tue, 19 Sep 2006 15:39:54 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E2FB214@zch01exm23.fsl.freescale.net>
In-Reply-To: <1158055669.3032.11.camel@laptopd505.fenrus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
Thread-Index: AcbWU1RaBNfamkOISuunBgRjHs96SwFayShw
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "jgarzik" <jgarzik@pobox.com>,
       <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have some review comments about your driver; please 
> consider them for
> fixing....
> 
Thanks.
> 
> > +		spin_unlock_irq(&phy_lock);
> > +		msleep(10);
> > +		spin_lock_irq(&phy_lock);
> > +	}
> 
> hmm some places take phy_lock with disabling interrupts, while others
> don't. I sort of fear "the others" may be buggy.... are you sure those
> are ok?
Could you interpret your comments in detail?
Roy
