Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUHLVKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUHLVKD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268795AbUHLVH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:07:28 -0400
Received: from the-village.bc.nu ([81.2.110.252]:48853 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268786AbUHLVBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:01:32 -0400
Subject: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE
	workaround?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Clem Taylor <clemtaylor@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411B89EA.3040400@pobox.com>
References: <411AFD2C.5060701@comcast.net>  <411B118B.4040802@pobox.com>
	 <1092312030.21994.25.camel@localhost.localdomain>
	 <411B89EA.3040400@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092340739.22362.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 20:59:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 16:16, Jeff Garzik wrote:
> > It fixes it completely on the drivers/ide driver.
> 
> SATA bus traces say otherwise.

Do you issue 15 or less or just combinations that are ok. With the 
siimage driver I just use the 15 limit and after hammering it hard
couldn't get it to fall over, while trying to be clever it did fall
over.

