Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270746AbTGUWYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 18:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270748AbTGUWYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 18:24:16 -0400
Received: from law11-oe66.law11.hotmail.com ([64.4.16.201]:54283 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270746AbTGUWYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 18:24:15 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.5.75 OK but tape backup not work
Date: Mon, 21 Jul 2003 16:39:16 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE66yNP29M5f8000100c8@hotmail.com>
X-OriginalArrivalTime: 21 Jul 2003 22:39:17.0741 (UTC) FILETIME=[EB66A9D0:01C34FD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My problem was resuelt (I installed  module inits again), now I can see all
modules loaded, but I have problems, when I want to see my backup, I can't ,
I execute tar tvf /dev/st0 and the follwing message appear:

tar: /dev/st0: Cannot open: No such device
tar: Error is not recoverable: exiting now

I believe that my server not know this device, but I  execute lsmod the
driver of my SCSI card is loaded:

scsi_mod              115892  2 dc395x,ide_scsi

I need to know that others test i can do it.

Thanks, You are very kind.

