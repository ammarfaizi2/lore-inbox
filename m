Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268525AbTCAIJl>; Sat, 1 Mar 2003 03:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268526AbTCAIJl>; Sat, 1 Mar 2003 03:09:41 -0500
Received: from mail.mediaways.net ([193.189.224.113]:34101 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268525AbTCAIJk>; Sat, 1 Mar 2003 03:09:40 -0500
Subject: Linux 2.4.21pre4-ac5 status report
From: Soeren Sonnenburg <kernel@nn7.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1046506460.1215.993.camel@sun>
Mime-Version: 1.0
Date: 01 Mar 2003 09:14:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.

I wanted to give some status report after using this kernel for 1 week.

The harddisk freeze bug that I got with WDC WD1800JB-00DUA0 drives did
not occur within this week (it used to happen within 5 days).

The promise driver still freezes on my pdc20268 when using >mdma0 . I
recently replaced the ultra tx2 controller with a hpt370 and it works
all fine. So I would suggest either removing the pdc20268 from the list
of supported controllers or letting promise fix this bug.

The overlay mode of my bt848 based tv card does not work anymore
(stripes as if the linewidth/offset is wrong).

Best,
Soeren (who has for the first time since some months an uptime of >1
week).

