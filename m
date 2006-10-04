Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWJDOOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWJDOOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWJDOON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:14:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16871 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161007AbWJDOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:14:12 -0400
Subject: Re: [PATCH] Generic platform device IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mundt <lethal@linux-sh.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de,
       ysato@users.sourceforge.jp
In-Reply-To: <20061004200501.GB6664@localhost.Internal.Linux-SH.ORG>
References: <20061004074535.GA7180@localhost.hsdv.com>
	 <1159962084.25772.14.camel@localhost.localdomain>
	 <20061004200501.GB6664@localhost.Internal.Linux-SH.ORG>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 15:38:45 +0100
Message-Id: <1159972725.25772.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 05:05 +0900, ysgrifennodd Paul Mundt:
> Ok, I wasn't sure if libata was intended for anything outside of the
> SATA case (especially non-PCI), but if that's the way to go, I'll look
> at hacking something up under libata.

Take a look at 2.6.18-mm or 2.6.19-* and you should see all you need in
that including the pcmcia driver and other users who set up much the
same way a generic platform device driver would.

