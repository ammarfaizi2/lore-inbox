Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUFWDrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUFWDrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 23:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUFWDrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 23:47:03 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:6805 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S265033AbUFWDql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 23:46:41 -0400
Date: Wed, 23 Jun 2004 04:46:24 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sata_sil quirk
In-Reply-To: <40D8FB8A.8040109@pobox.com>
Message-ID: <Pine.LNX.4.60.0406230442410.2702@fogarty.jakma.org>
References: <40D89509.6010502@pobox.com> <Pine.LNX.4.60.0406230421220.2702@fogarty.jakma.org>
 <40D8FB8A.8040109@pobox.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Jeff Garzik wrote:

> Cool.  Yeah, non-Seagate should be full speed and unaffected...

But I got the impression your patch enables mod15-quirk for all LBA48 
drives, is that correct? If so, if I have to update kernels here, I 
think I'll reverse that one if it affects all LBA48, as I'd rather 
not suffer the performance hit (its slow enough already because of 
slow CPU/chipset/contended PCI bus thank you very much ;) ) - until 
such time as a better fix is known.

> 	Jeff

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
 	warning: do not ever send email to spam@dishone.st
Fortune:
It is so soon that I am done for, I wonder what I was begun for.
 		-- Epitaph, Cheltenham Churchyard
