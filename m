Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423317AbWJSL53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423317AbWJSL53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423318AbWJSL53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:57:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59520 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423317AbWJSL52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:57:28 -0400
Subject: RE: kernel oops with extended serial stuff turned on...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Greg KH <greg@kroah.com>, Greg.Chandler@wellsfargo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com>
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com>
	 <20061018230939.GA7713@kroah.com>
	 <335DD0B75189FB428E5C32680089FB9FA473E9@mtk-sms-mail01.digi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 13:00:04 +0100
Message-Id: <1161259204.17335.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 19:20 -0500, ysgrifennodd Kilau, Scott:
> Turns out that the driver/char/isicom.c driver claimed his board, and then
> tried to register the ttyM0 name, which apparently someone else
> in the kernel did already...

ISIcom is the official owner of /dev/ttyM* so the real question as you
say is who else tried to claim it. Fortunately Greg is also Mr Udev 8)

