Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTFFPPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbTFFPPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:15:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47249
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261876AbTFFPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:15:36 -0400
Subject: Re: 2.4.21-rc7 AMD64 dpt_i2o fails compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Warren Togami <warren@togami.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054877581.3699.113.camel@laptop>
References: <1054789161.3699.67.camel@laptop.suse.lists.linux.kernel>
	 <20030605010841.A29837@devserv.devel.redhat.com.suse.lists.linux.kernel>
	 <1054799692.3699.77.camel@laptop.suse.lists.linux.kernel>
	 <1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel>
	 <p73wug067qb.fsf@oldwotan.suse.de>
	 <1054842344.15457.43.camel@dhcp22.swansea.linux.org.uk>
	 <1054877581.3699.113.camel@laptop>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054913201.17185.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jun 2003 16:26:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-06 at 06:33, Warren Togami wrote:
> http://www.adaptec.com/worldwide/support/suppdetail.html?cat=%2fProduct%2fASR-2110S&prodkey=ASR-2110S
> http://www.adaptec.com/worldwide/support/techspecs.html?prodkey=ASR-2110S&cat=%2fProduct%2fASR-2110S
> Adaptec SCSI RAID 2110S claims to be a "64-bit/66MHz PCI-to-SCSI RAID
> card".  The physical card is longer than normal 32-bit PCI cards with
> more pins that fit into a "64-bit PCI slot".  Are Adaptec's claims of
> 64-bit hardware false?

64bit bus isnt the same thing as 64bit capable or 64bit safe. The
current driver will need some work for the latter

