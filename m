Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVGVO1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVGVO1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGVO1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:27:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47597 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262101AbVGVO06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:26:58 -0400
Subject: Re: DriveStatusError BadCRC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sampei02@tiscali.it
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <42D7AA0C000145DB@mail-8.mail.tiscali.sys>
References: <42D7AA0C000145DB@mail-8.mail.tiscali.sys>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 15:51:20 +0100
Message-Id: <1122043881.9478.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-22 at 11:16 +0200, sampei02@tiscali.it wrote:
> I already used 80-wire cable and my Maxtor HD plugs are seated properly.
> My Kernel is 2.6.12-1.1372 on Fedora Core 3
> HD is 80 GB Maxtor ATA/133
> With hdparm command I can see hda is set in "udma5" mode, but why is'it not
> udma6 (133 Mhz) ? Can it be problem ?!

UDMA6 requires both the controller and drive can handle that speed. A
lot of common controllers only handle UDMA5.

