Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUFUR24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUFUR24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 13:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUFUR24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 13:28:56 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:16510 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266344AbUFUR2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 13:28:55 -0400
To: areversat@tuxfamily.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of pci express in kernel
X-Message-Flag: Warning: May contain useful information
References: <1087837920.9636.1.camel@nibbler>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 21 Jun 2004 10:28:48 -0700
In-Reply-To: <1087837920.9636.1.camel@nibbler> (areversat@tuxfamily.org's
 message of "Mon, 21 Jun 2004 19:12:00 +0200")
Message-ID: <52u0x4u8fj.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Jun 2004 17:28:49.0252 (UTC) FILETIME=[36C0D240:01C457B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    areversat> Hi, I've read today that intel is going to launch it's
    areversat> first pci express chipsets soon. So i was wondering if
    areversat> the support of this bus was already a work in progress
    areversat> or if it wasn't yet started ?

PCI Express is backwards compatible with standard PCI, so even fairly
old Linux kernels boot and work fine with PCI Express devices.  2.6
kernels also have support for accessing the new features of PCI
Express (ie extended PCI header fields).

 - Roland
