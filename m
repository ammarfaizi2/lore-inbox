Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVCCUR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVCCUR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCCUNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:13:52 -0500
Received: from mail1.kontent.de ([81.88.34.36]:1459 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262121AbVCCUKw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:10:52 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pasi Savolainen <psavo@iki.fi>
Subject: Re: [linux-usb-devel] [2.6 patch] remove drivers/usb/image/hpusbscsi.c
Date: Thu, 3 Mar 2005 21:11:02 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20050303133856.GT4608@stusta.de> <200503031613.36758.oliver@neukum.org> <slrnd2eqp4.19r.psavo@varg.dyndns.org>
In-Reply-To: <slrnd2eqp4.19r.psavo@varg.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503032111.03600.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. März 2005 20:48 schrieb Pasi Savolainen:
> * Oliver Neukum <oliver@neukum.org>:
> > Am Donnerstag, 3. März 2005 14:38 schrieb Adrian Bunk:
> >> USB_HPUSBSCSI was marked as BROKEN in 2.6.11 since libsane is the 
> >> preferred way to access these devices.
> >
> > That is true only if you limit yourself to users of SANE.
> > Other, rarer scan systems like VueScan use it. At least last time
> > somebody mentioned them.
> 
> Vuescan uses libusb these days, didn't need hpusbscsi last time I used
> it.
> I don't know about other (program-) users.

OK. That should solve the issue. It can go.

	Regards
		Oliver
