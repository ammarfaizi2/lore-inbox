Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWCXEqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWCXEqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 23:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423029AbWCXEqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 23:46:04 -0500
Received: from dsl017-055-116.sfo1.dsl.speakeasy.net ([69.17.55.116]:42127
	"EHLO mail.murgatroid.com") by vger.kernel.org with ESMTP
	id S1423026AbWCXEpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 23:45:40 -0500
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Jean Delvare'" <khali@linux-fr.org>
Cc: <lm-sensors@lm-sensors.org>, <linux-kernel@vger.kernel.org>,
       <kernel-janitors@lists.osdl.org>, "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: [PATCH] Clean up magic numbers in i2c_parport.h
Date: Thu, 23 Mar 2006 20:45:36 -0800
Message-ID: <000e01c64efd$cae7f750$8401000a@fakie>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcZOs8NWJPZtuPucTbuyy2DFIEDsZAASeraA
In-Reply-To: <20060323205617.38e02afe.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Beeuh. These macros don't really help. They actually make the lines
longer! I'm not taking this change, sorry.

If I kill off the macros but continue to use C99 structure initializers,
which is I believe is the proper kernel coding style today, the lines are
going to get even longer.  Is that OK?

Or are you asking for the patch w/o macros and w/o C99 structure
initializers?

I can/will do either.  Just let me know what is acceptable a priori.

-ch

