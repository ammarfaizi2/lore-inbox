Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUEGBPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUEGBPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 21:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUEGBPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 21:15:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:51134 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262085AbUEGBPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 21:15:39 -0400
Subject: Re: Force IDE cache flush on shutdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200405061338.50311.bzolnier@elka.pw.edu.pl>
References: <20040506070449.GA12862@devserv.devel.redhat.com>
	 <20040506084918.B12990@infradead.org>
	 <200405061338.50311.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1083892151.20000.113.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 11:09:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> There is one problem with using ->shutdown:
> handling of SYS_RESTART isn't the same as of SYS_HALT and SYS_POWER_OFF.

See my other comment... I think this duplicates what the suspend 
callback does (though fixing that might not be a 2.6 option).

Ben.


