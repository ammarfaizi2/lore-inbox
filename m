Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292421AbSBZRjm>; Tue, 26 Feb 2002 12:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292447AbSBZRja>; Tue, 26 Feb 2002 12:39:30 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:32411 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S292423AbSBZRij>; Tue, 26 Feb 2002 12:38:39 -0500
Message-ID: <000901c1beec$6ac68940$030ba8c0@mistral>
From: "Simon Turvey" <turveysp@ntlworld.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: IDE error on 2.4.17
Date: Tue, 26 Feb 2002 17:38:35 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a large file (4gigs) transfer using Samba attempts to access the file
(also across Samba) resulted in lots of the following type of message.

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=250746,
sector=250680
end_request: I/O error, dev 03:01 (hda), sector 250680

Can anyone point me in the direction of a reason/solution?

Thanks,
    Simon



