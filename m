Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUA1L0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbUA1L0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:26:32 -0500
Received: from linux-bt.org ([217.160.111.169]:15793 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S265911AbUA1L0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:26:31 -0500
Subject: Re: Firmware loader dependency question 2.4/2.6
From: Marcel Holtmann <marcel@holtmann.org>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20040128120748.00a8f140@pop.t-online.de>
References: <5.1.0.14.2.20040128120748.00a8f140@pop.t-online.de>
Content-Type: text/plain
Message-Id: <1075289160.12766.69.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 28 Jan 2004 12:26:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Margit,

> Why is the firmware loader dependent on CONFIG_HOTPLUG ?
> For PCI cards that require this, it should not be necessary.

because it has to call firmware.agent to transfer the firmware file from
your harddisk into the /sys or /proc data file.

Regards

Marcel


