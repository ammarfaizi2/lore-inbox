Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271945AbTGRWnC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271941AbTGRWmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:42:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8920
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271939AbTGRWmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:42:20 -0400
Subject: Re: DVD-RAM crashing system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Svein Ove Aas <svein.ove@aas.no>
Cc: Nachman Yaakov Ziskind <awacs@egps.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200307190008.32137.svein.ove@aas.no>
References: <20030718160643.A21755@egps.egps.com>
	 <200307190008.32137.svein.ove@aas.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058568886.19512.111.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 23:54:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 23:08, Svein Ove Aas wrote:
> My suggestion is this: As the hardware is obviously broken, and disabling DMA 
> would cause a horrendous performance drop anyway, you should get a new 
> chipset. Return the one you have as broken.

Update to 2.4.20. That will put IDE disks into MWDMA2 on the Serverworks
OSB4 and avoid the mistrigger with CD-ROM errors. The later serverworks
(CSB5, CSB6) is fine btw but can hit the CD-ROM mistrigger too

