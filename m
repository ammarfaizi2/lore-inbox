Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUFJS6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUFJS6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUFJS6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:58:48 -0400
Received: from cyberhostplus.biz ([209.124.87.2]:52123 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S262406AbUFJS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:57:46 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: "'Jan Dittmer'" <j.dittmer@portrix.net>, <linux-kernel@vger.kernel.org>
Subject: RE: APIC error on CPU1: 00(02) && APIC error on CPU0: 00(02)
Date: Thu, 10 Jun 2004 13:57:47 -0500
Message-ID: <000c01c44f1c$d6b1ed80$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <40C8A3F1.7020007@portrix.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They are genuine AMD Athlon 1900 MPs (never over-clocked) on a Giga-byte
7DPXDW-P.  The only time these errors seem to occur is when the system
is under heavy disk activity.  Could there be a bug with the APIC timer?
This motherboard has two ide-controllers on board.  I've noticed in the
log:

Enabling APIC mode:  Flat.  Using 1 I/O APICs

Is this correct, or should it be 2 I/O APICs?

I'm really fishing for answers.  I'd like to know if there really is
something wrong with my system (although it still seems rock stable) or
is this possible a kernel bug?

I'm currently using 2.6.7-rc3 compiled with gcc 3.4.0.

Thanks,
Steve


-----Original Message-----
From: Jan Dittmer [mailto:j.dittmer@portrix.net] 
Sent: Thursday, June 10, 2004 1:10 PM
To: Steve Lee
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU1: 00(02) && APIC error on CPU0: 00(02)

Steve Lee wrote:
> APIC error on CPU1: 00(02)
> APIC error on CPU0: 00(02)

Is this a Dual AMD Platform? If yes, are this real MPs or just modded 
XPs? I've had this kind of error for years on a dual AMD with modded XPs

on a Tyan 2460 - until now, no processor broke down. The APIC is very 
picky on this board, judging different posts from the internet.

Jan


