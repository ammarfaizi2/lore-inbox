Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVAQSuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVAQSuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVAQSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:50:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32137 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262467AbVAQSrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:47:47 -0500
Subject: Re: usb-storage on SMP?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200501171826.33496.rjw@sisk.pl>
References: <1105982247.21895.26.camel@hostmaster.org>
	 <200501171826.33496.rjw@sisk.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105983790.16119.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 17:43:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 17:26, Rafael J. Wysocki wrote:
> On Monday, 17 of January 2005 18:17, Thomas Zehetbauer wrote:
> > Hi,
> > 
> > can anyone confirm that writing to usb-storage devices is working on SMP
> > systems?
> 
> Generally, it is.  Recently, I've written some stuff to a USB pendrive (using
> 2.6.10-ac7 or -ac9).

I'm dumping stuff to large hard disks via USB2 with 2.6.9 and 2.6.10
reliably. With 2.4.x until very late and with 2.6.early it would hang
reliably. It now seems pretty solid. It does panic the box if you remove
the drive while its in use which IMHO is *bad* but thats harder to fix.

