Return-Path: <linux-kernel-owner+w=401wt.eu-S1751276AbXAPPgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXAPPgG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 10:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXAPPgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 10:36:06 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33983 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751276AbXAPPgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 10:36:05 -0500
Date: Tue, 16 Jan 2007 15:47:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Olivier Galibert" <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: What does this scsi error mean ?
Message-ID: <20070116154752.782a605e@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0701160959450.8079@chaos.analogic.com>
References: <20070115171602.GA23661@dspnet.fr.eu.org>
	<20070115184540.2b3c4f78@localhost.localdomain>
	<20070115214503.GA56952@dspnet.fr.eu.org>
	<Pine.LNX.4.61.0701160959450.8079@chaos.analogic.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correctable SCSI errors show that the data in a sector was not properly
> read, but the device was able to fix the data error because of the
> redundancy in the CRC. The error could be permanently fixed is you
> rewrote the sector. You probably don't know where the bad sector is

The drives do that automatically, and the SCSI verify did it for him too
if there were any other problems.

