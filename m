Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268476AbTGIRXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbTGIRXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:23:13 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:23188 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S268476AbTGIRW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:22:57 -0400
Subject: Compile failure 2.4.22-pre3-ac1
From: Midian <midian@ihme.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1057770255.6255.70.camel@dhcp22.swansea.linux.org.uk>
References: <20030709124915.3d98054b.ak@suse.de>
	 <1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
	 <20030709134109.65efa245.ak@suse.de>
	 <1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
	 <20030709185823.1f243367.ak@suse.de>
	 <1057770255.6255.70.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1057772247.3757.9.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 20:37:27 +0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,
I've tryed to compile 2.4.22-pre3-ac1, but every time I get this error:

arch/i386/kernel/kernel.o(.text.init+0x7803): In function
`setup_ioapic_ids_from_mpc':
: undefined reference to `xapic_support'
arch/i386/kernel/kernel.o(.text.init+0x7a16): In function
`setup_ioapic_ids_from_mpc':
: undefined reference to `xapic_support'
make: *** [vmlinux] Error 1

I've tryed to search for patches from the mailing list with no luck, is
there some patches for this?

Regards
-- 
Markus Hästbacka <midian@ihme.org>

