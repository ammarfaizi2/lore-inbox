Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285020AbRLUT0f>; Fri, 21 Dec 2001 14:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285014AbRLUT0S>; Fri, 21 Dec 2001 14:26:18 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:38872 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S285020AbRLUTYw>; Fri, 21 Dec 2001 14:24:52 -0500
From: "Ashok Raj" <ashokr2@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: ksoftirqd_CPUX kernel daemons...
Date: Fri, 21 Dec 2001 11:24:43 -0800
Message-ID: <PPENJLMFIMGBGDDHEPBBCEIKCAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Could someone explain me why the kernel daemons (ksoftirqd that exists one
per CPU and each kernel thread has affinity to a single CPU) run with very
low priority?

mdrecovery etc run at very high priority (nice -20) but these softirq
daemons that run all the tasklet processing run as very low priority
threads.

is there a specific reason for this?

thanks
ashokr

