Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVAFRCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVAFRCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVAFRCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:02:21 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:37650 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S262913AbVAFRCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:02:20 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <Tim_T_Murphy@Dell.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [2.6.10-bk8] [SERIAL] dropping chars when > 512
Date: Thu, 6 Jan 2005 12:02:18 -0500
Organization: Connect Tech Inc.
Message-ID: <00f101c4f411$7ae33af0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D30@ausx2kmps304.aus.amer.dell.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim_T_Murphy@Dell.com [mailto:Tim_T_Murphy@Dell.com] 
> Nope, not a typo.
> I'm no expert, but i thought 'status' shows the LSR when an interrupt
> occurs, and LSR = 1 indicates 'data available', while LSR = 
> 60 indicates
> transmitter status (40 = THR empty, 20 = THR + shift register empty)?
> so status = 1 indicates an interrupt occurs while transmitter is busy?

That's what I get for not checking the code first. You are correct;
that is exactly what's going on. It shouldn't be a problem.

> I think this is related to tty flip buffer full (size = 512), and no
> low_latency setting (which, if set, hangs the 2.6 SMP 
> kernel).  but i'm
> not expert enough with serial to know a fix.

That is possible; I'm not familiar with the 2.6 drivers yet so I can't
be of more help.

..Stu

