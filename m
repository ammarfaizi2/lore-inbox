Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270092AbUJVIFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270092AbUJVIFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269830AbUJVIF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:05:27 -0400
Received: from vsmtp2alice.tin.it ([212.216.176.142]:43945 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S269840AbUJVIEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:04:51 -0400
Date: Fri, 22 Oct 2004 10:13:35 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Luc Saillard <luc@saillard.org>
Subject: Re: Linux 2.6.9-ac3
Message-Id: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o       Restore PWC driver                              (Luc Saillard)

This driver does decompression in kernel space, which is not
allowed. That part has to be removed from the driver before
asking for the inclusion in the mainline kernel.

Regards,
	Luca Risolia

