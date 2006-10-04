Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161845AbWJDRFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161845AbWJDRFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161828AbWJDRFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:05:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12740 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161804AbWJDRFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:05:14 -0400
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Owen <r.alex.owen@gmail.com>
Cc: linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net,
       aabdulla@nvidia.com
In-Reply-To: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 18:30:49 +0100
Message-Id: <1159983049.25772.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 17:19 +0100, ysgrifennodd Alex Owen:
> The obvious fix for this is to try and read the MAC address from the
> canonical location... ie where is the source of the address writen
> into the controlers registers at power on? But do we know where that
> may be?

Why not check if the first or last 3 bytes are the Nvidia owner bits.
The only card that will misdetect is 

00:16:17:17:16:00

which doesn't matter anyway

Alan

