Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269218AbRGaImN>; Tue, 31 Jul 2001 04:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269219AbRGaImD>; Tue, 31 Jul 2001 04:42:03 -0400
Received: from [216.6.80.34] ([216.6.80.34]:38416 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S269218AbRGaIlr>; Tue, 31 Jul 2001 04:41:47 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C6508E@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: linux-kernel@vger.kernel.org
Subject: Why istn't dup in TCP working??
Date: Tue, 31 Jul 2001 14:12:41 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,
		I used functions of socket's operation structure like 
create, bind, connect, dup etc.in the kernel for transfering data over 
TCP from the kernel. 
		Now this is working fine in 2.2.x but when I compiled my 
module in 2.4.x the first error that I get is that dup is not a 
part of socket's operation structure anymore. 
		So what is the replacement for it, I couldn't find any
in the proto_ops structure?

Regards,
Nitin
