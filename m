Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUESSM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUESSM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUESSM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 14:12:28 -0400
Received: from vogsphere.datenknoten.de ([212.12.48.49]:58285 "EHLO
	vogsphere.datenknoten.de") by vger.kernel.org with ESMTP
	id S264484AbUESSM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 14:12:27 -0400
Subject: Re: Strange DMA-errors and system hang with Promise 20268
From: Sebastian <sebastian@expires0604.datenknoten.de>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040519172845.GA26122@darkside.22.kls.lan>
References: <1078602426.16591.8.camel@vega> <c2dsha$psd$1@sea.gmane.org>
	 <1084987258.4662.4.camel@coruscant.datenknoten.de>
	 <20040519172845.GA26122@darkside.22.kls.lan>
Content-Type: text/plain
Message-Id: <1084990345.4371.5.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 20:12:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 19.05.2004 schrieb Mario 'BitKoenig' Holbe um 19:28:
> WDC drives involved by accident (i.e. do you have any
> WDC drive connected to your promise controller(s))?

Actually, it is not a promise controller.

Setup:
00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
(rev 02)

Device Model:     IC35L040AVER07-0

Symptoms are the same, though.

> > suggested, but too recently to be sure that it was the cause. It could
> > just be related to additional load caused by cron jobs?
> 
> Yes.
> 
> > Any confirmed solutions yet?
> 
> Depends :) Not really.
> Currently, I suspect it to be some Promise<->WDC issue,
> thus it depends on your answer to my question :)

Hhmm. I have not changed anything major on that machine except the
Kernel for years. Only after upgrading from 2.4.23 to 2.4.25, I got
these problems. 
If there is no problem with the kernel, I have to assume a hardware
failure of some kind. Badblocks/smartlog reveal no errors.

Sebastian

