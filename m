Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVCHWVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVCHWVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVCHWVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:21:00 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:56080 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261596AbVCHWUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:20:54 -0500
Date: Tue, 8 Mar 2005 23:21:00 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
Message-Id: <20050308232100.6a9248f2.khali@linux-fr.org>
In-Reply-To: <422E24A8.4070504@tmr.com>
References: <11099696383203@kroah.com>
	<11099696391236@kroah.com>
	<422E24A8.4070504@tmr.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

> > [PATCH] PCI: One more Asus SMBus quirk
> > 
> > One more Asus laptop requiring the SMBus quirk (W1N model).
> 
> Hopefully this and the double-free patch will be included in
> 2.6.11.n+1?  They seem to fit the "real bug" criteria.

I see nothing critical in this patch. It gives access to a chip. Without
the patch you cannot access the chip, and that's about it. No bug there,
only a missing feature.

Can't speak for the "double-free patch", don't know what it is all
about.

-- 
Jean Delvare
