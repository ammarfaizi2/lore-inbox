Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272341AbTHNNou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272342AbTHNNou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 09:44:50 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:31740 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272341AbTHNNot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 09:44:49 -0400
Subject: Re: [PATCH] ide: limit drive capacity to 137GB if host doesn't
	support LBA48
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308141448.27905.bzolnier@elka.pw.edu.pl>
References: <200308140324.45524.bzolnier@elka.pw.edu.pl>
	 <1060851207.5535.15.camel@dhcp23.swansea.linux.org.uk>
	 <200308141448.27905.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060868663.5982.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 14 Aug 2003 14:44:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 13:48, Bartlomiej Zolnierkiewicz wrote:
> Its hwif->addressing not drive->addressing.  Look at the current usage.
> It is 1 when host doesn't support LBA48, otherwise its 0.  We can add "real"

Ok.

> hwif->addressing when needed.  IDE driver is already full of unfinished,
> unused "features".

Thats painfully true.

-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>
