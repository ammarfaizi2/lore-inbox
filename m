Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWFPC41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWFPC41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 22:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWFPC41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 22:56:27 -0400
Received: from mf2.realtek.com.tw ([60.248.182.46]:40208 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S1750795AbWFPC40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 22:56:26 -0400
Message-ID: <043701c690f0$71f15530$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: Solve the problem that umount will fail when an opened file isn't closed
Date: Fri, 16 Jun 2006 10:56:19 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/16 =?Bog5?B?pFekyCAxMDo1NjoyMA==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2006/06/16 =?Bog5?B?pFekyCAxMDo1NjoyMQ==?=,
	Serialize complete at 2006/06/16 =?Bog5?B?pFekyCAxMDo1NjoyMQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
I have implemented an auto-mount & auto-umount facility based on USB
hotplug.
An annoying problem will occur when some process doesn't close its open file
and auto-umount is trying to umount that mount point after usb disk has been
unplugged.
Is there any way to force it to be umounted in this situation?

Regards,
Colin

