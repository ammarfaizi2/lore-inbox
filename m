Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSCDGtJ>; Mon, 4 Mar 2002 01:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSCDGs7>; Mon, 4 Mar 2002 01:48:59 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:64161 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S291948AbSCDGst>; Mon, 4 Mar 2002 01:48:49 -0500
Message-ID: <010501c1c348$ca70b450$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Hans-Christian Armingeon" <linux.johnny@gmx.net>
Cc: <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.fifmv4v.ogc1qa@ifi.uio.no> <fa.jgnh1iv.1ek48ih@ifi.uio.no>
Subject: Re: Recommendations about a 100/10 NIC
Date: Mon, 4 Mar 2002 01:49:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a 3com 905b, the current model is a 3com 905C-TX
> like you mentioned. Which of those cards supports calculating
> ethernet checksums in hardware?

Based on my reading of 3c59x.c, 3c905B and 3c905C cards - but not the
original 3c905 - will do TCP checksums in hardware (and thus enable
zero-copy data transfer).

Regards,
Dan

