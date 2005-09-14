Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbVINLnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbVINLnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 07:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbVINLnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 07:43:21 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:47886 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S932728AbVINLnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 07:43:21 -0400
Message-ID: <001901c5b909$02b27060$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: seq_file problem
Date: Wed, 14 Sep 2005 16:48:00 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/09/14 =?Bog5?B?pFWkyCAwNDo0ODowMQ==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/09/14 =?Bog5?B?pFWkyCAwNTowMTo1Ng==?=,
	Serialize complete at 2005/09/14 =?Bog5?B?pFWkyCAwNTowMTo1Ng==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,
Can we use seq_printf in the "next" function?
I found that the "last" next function can print to userland, but the others
donot.
However, every "show" function can truely print to userland.
I doubt that it's not allowable to use seq_printf in the "next" function.

Regards,
Colin



