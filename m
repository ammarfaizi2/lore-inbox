Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262944AbSJFWoF>; Sun, 6 Oct 2002 18:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbSJFWoF>; Sun, 6 Oct 2002 18:44:05 -0400
Received: from nl-ams-slo-l4-02-pip-8.chellonetwork.com ([213.46.243.28]:37216
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262944AbSJFWoD>; Sun, 6 Oct 2002 18:44:03 -0400
Subject: sleeping function called from illegal context (asm/semaphore.h)
From: Harm Verhagen <h.verhagen@chello.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-4) 
Date: 07 Oct 2002 00:49:07 +0200
Message-Id: <1033944547.2476.15.camel@pchome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Booting into 2.5.40 (upto changeset 1.754) I found this in my logs:



Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c01149e2>] E __might_sleep_Rd533bec7+0x52/0x2d3ad8
 [<c02b9765>] E usb_hub_tt_clear_buffer_Rbe74a884+0xf45/0xffffe690
 [<c02b9a00>] E usb_hub_tt_clear_buffer_Rbe74a884+0x11e0/0xffffe690
 [<c02b9a35>] E usb_hub_tt_clear_buffer_Rbe74a884+0x1215/0xffffe690
 [<c02b9a00>] E usb_hub_tt_clear_buffer_Rbe74a884+0x11e0/0xffffe690
 [<c01137b0>] E default_wake_function_Rfe478e92+0x0/0xa0
 [<c01054d9>] E enable_hlt_R9c7077bd+0x1c9/0x16960

I hope this is usefull info...

please CC me if you have questions as I'm not subscribed.

Kind regards,
Harm Verhagen


