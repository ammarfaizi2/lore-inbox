Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbRDINmm>; Mon, 9 Apr 2001 09:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRDINmc>; Mon, 9 Apr 2001 09:42:32 -0400
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:3077 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S132752AbRDINmT>; Mon, 9 Apr 2001 09:42:19 -0400
Message-ID: <012a01c0c0fb$b9305290$ae58718c@cis.nctu.edu.tw>
From: "nctucis" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: skbuff.h
Date: Mon, 9 Apr 2001 21:48:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use 2.2.16 kernel.
I found that there is a sk_buff structure in
"/usr/src/linux/include/linux/skbuff.c", and
there is a variable "unsigned in csum;" in 
the sk_buff structure.

I want to know this checksum check what information.
Could you give me a hand, please?

-=-=-=-=-=-=-=-
In fact, I found 64byte and 1518byte UDP packet waste different
time to do masquerade(ip_fw_masquerade). 
Many books say NAT just modify header fields, so it should no 
different between small and big packet size.
I guess the different time due to csum_partial(h.raw, doff, sum)
in ip_fw_masquerade(). Right? Thanks a lot.
(But I can't find out source code of this function.)

Cheers,
Tom


