Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbULROVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbULROVv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULROVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:21:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1423 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261168AbULROVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:21:02 -0500
Date: Sat, 18 Dec 2004 15:20:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: usbdevfs mount failure with 2.6.10-rc3
In-Reply-To: <04I4WDU12@server5.heliogroup.fr>
Message-ID: <Pine.LNX.4.61.0412181520230.13495@yvahk01.tjqt.qr>
References: <04I4WDU12@server5.heliogroup.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>With 2.6.10-rc3 I get ENODEV error when trying to mount usbdevfs
>No problem with 2.6.9

Is it already tagged obsolete? Cat /proc/filesystems and see if usbdevfs is 
there at all.
Try mounting 'usbfs' instead of 'usbdevfs'.



Jan Engelhardt
-- 
ENOSPC
