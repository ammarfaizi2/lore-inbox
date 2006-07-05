Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWGEO3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWGEO3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWGEO3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:29:21 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:20893 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964886AbWGEO3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:29:20 -0400
Subject: Re: [RFC] change netdevice to use struct device instead of struct
	class_device
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060703224719.GA14176@kroah.com>
References: <20060703224719.GA14176@kroah.com>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 16:29:23 +0200
Message-Id: <1152109763.4260.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> The patch needs some other changes to the driver core that are also in
> my git tree, and included in the -mm release.  Specifically these
> patches are needed:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/device-groups.patch
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/device-class-parent.patch

while converting the Bluetooth subsystem from class devices to real
devices, I had some similar situation with devices without parent. I
actually used a Bluetooth platform device as parent for virtual or
serial based devices.

Regards

Marcel


