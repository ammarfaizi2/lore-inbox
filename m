Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268902AbSIRSyy>; Wed, 18 Sep 2002 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbSIRSyy>; Wed, 18 Sep 2002 14:54:54 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:42406 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S268902AbSIRSyx>; Wed, 18 Sep 2002 14:54:53 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: <linux-kernel@vger.kernel.org>
Subject: interruptible_sleep_on_timeout() and signals
Date: Wed, 18 Sep 2002 11:56:36 -0700
Message-ID: <024501c25f45$1db02360$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0209182049170.26337-100000@localhost.localdomain>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

How would I figure out whether interruptible_sleep_on_timeout() returned on
a timeout condition, someone called wakeup() or the user pressed CTRL-C
i.e., interrupted by a signal?
Is signal_pending()the right choice ?

Thanks,
Imran.



