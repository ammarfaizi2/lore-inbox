Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSGYOzC>; Thu, 25 Jul 2002 10:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSGYOzC>; Thu, 25 Jul 2002 10:55:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10991 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315439AbSGYOzB>; Thu, 25 Jul 2002 10:55:01 -0400
Subject: Re: PCI config locking (WAS Re: [RFC/CFT] cmd640 irqlocking fixes)2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: benh@kernel.crashing.org
Cc: Andre Hedrick <andre@linux-ide.org>, martin@dalecki.de,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020725144005.8706@smtp.adsl.oleane.com>
References: <1027611916.9488.79.camel@irongate.swansea.linux.org.uk> 
	<20020725144005.8706@smtp.adsl.oleane.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 17:10:35 +0100
Message-Id: <1027613435.9489.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, all config operations are going through the
> pci_read/write_config_xxxx in drivers/pci/pci.c or access.c (2.5)
> which will take the pci_lock already. Couldn't x86 use that instead
> of stacking another lock ?

I'll take a look. We probably can

