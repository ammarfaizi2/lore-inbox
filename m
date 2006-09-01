Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWIAWnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWIAWnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWIAWnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:43:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41424 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751154AbWIAWnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:43:05 -0400
Subject: Re: File corruption with 2940U2 SCSI card and aic7xxx driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ethan <thesyntheticsophist@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ea0b05b30609010905v341ba10ap5a7638e1d91faa5b@mail.gmail.com>
References: <ea0b05b30609010905v341ba10ap5a7638e1d91faa5b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 02 Sep 2006 00:05:27 +0100
Message-Id: <1157151927.6271.341.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-01 am 09:05 -0700, ysgrifennodd Ethan:
> detected and identified by the kernel at boot.  Unfortunately, I am
> experiencing consistent corruption on large files written to the SCSI
> drives.  For example, if I copy a file from the old, stable IDE drive
> to one of the SCSI disks using dd:

Does this still occur with a more recent upstream kernel ?


There are also known AHA2940 incompatibilities with a few boards. People
always had problems with CUV4X* boards for one. Bit early to assume its
the board however it might be worth making sure the card is well seated
and the cabling looks good. That said I'd expect parity errors..



-- 
VGER BF report: H 0.215243
