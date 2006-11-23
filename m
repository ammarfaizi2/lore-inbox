Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933603AbWKWLRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603AbWKWLRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933614AbWKWLRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:17:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34281 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933603AbWKWLRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:17:37 -0500
Date: Thu, 23 Nov 2006 11:22:51 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
Message-ID: <20061123112251.7976994c@localhost.localdomain>
In-Reply-To: <1164269159.31358.769.camel@laptopd505.fenrus.org>
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com>
	<1164269159.31358.769.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is this really the right thing? You're overriding a user chosen
> configuration here.... while that might be justifiable.. it's probably a
> good idea to at least provide a safety-valve for this one. The user
> might have made that selection very deliberately.

Its what we do for other similar cases and I think its the right thing to
do in this situation. One reason for this is that with multi-boot boxes
you have to set the BIOS option to the dumbest one unless the smart OS's
reconfigure the device.

Alan
