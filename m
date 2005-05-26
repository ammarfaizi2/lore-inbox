Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVEZUP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVEZUP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVEZUP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:15:26 -0400
Received: from mail.emacinc.com ([208.248.202.76]:18849 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id S261596AbVEZUPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:15:19 -0400
From: NZG <ngustavson@emacinc.com>
Organization: EMAC.Inc
To: linux-kernel@vger.kernel.org
Date: Thu, 26 May 2005 15:14:20 -0500
User-Agent: KMail/1.7.1
Cc: uclinux-dev@uclinux.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505261514.20107.ngustavson@emacinc.com>
X-SA-Exim-Connect-IP: 208.248.202.77
X-SA-Exim-Mail-From: ngustavson@emacinc.com
Subject: 2.6 block immediate write
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm developing a generic MMC driver using SPI protocol for the 2.6 kernel.

I want this device to be compatible with uClinux distributions, so I need to 
be able to set up the request queue so that writes to the device happen 
immediately, rather than delaying until they "have to" happen, such as on an 
umount.

1. is this possible?
2. can anyone point me towards some good documentation as to the correct way 
to set up the queue?

I've gone through ldd3, but it seems a little ambiguous on this point.

I hope this is a valid question for the vger list.
I think it is, but I'm a bit new to it.

thx,
NZG.
