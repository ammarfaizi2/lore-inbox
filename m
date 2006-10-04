Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWJDLQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWJDLQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030814AbWJDLQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:16:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10215 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030791AbWJDLQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:16:32 -0400
Subject: Re: [PATCH] Generic platform device IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mundt <lethal@linux-sh.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de,
       ysato@users.sourceforge.jp
In-Reply-To: <20061004074535.GA7180@localhost.hsdv.com>
References: <20061004074535.GA7180@localhost.hsdv.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 12:41:24 +0100
Message-Id: <1159962084.25772.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 16:45 +0900, ysgrifennodd Paul Mundt:
> This is intended purely for the simple NO_DMA ide_generic case.. nothing
> complicated.
> 
> What do people think about this, is there a better way to do this?

drivers/ide is going away over time. I think the concept is nice and
it's sort of reflected in the libata VLB drivers. I think it would be a
very good way to get good platform drivers for libata for the embedded
platforms.

Moving the existing drivers/ide stuff to a new drivers/ide variant is
wasted work however.


