Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136240AbRDVR46>; Sun, 22 Apr 2001 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136242AbRDVR4t>; Sun, 22 Apr 2001 13:56:49 -0400
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:21261 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S136240AbRDVR4k>; Sun, 22 Apr 2001 13:56:40 -0400
Message-ID: <00bd01c0cb56$7f0f29a0$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: BPF and SKB
Date: Mon, 23 Apr 2001 02:03:09 +0800
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

Hello,

I have study the BPF, and I know it calls Socket Filtering in Linux.
    (user)
        |
    (buffer)
        |
    (BPF)    (origin protocol stack)
        |           |
    (Data Link Layer)

Does the buffer above BPF is skb_buff?
If yes, origin protocol stack will get packet from it.
After the packet be processed, the packet in the buffer will be del.
Right? Thanks for your advise.




