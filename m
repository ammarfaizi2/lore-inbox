Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318939AbSH1T2d>; Wed, 28 Aug 2002 15:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318941AbSH1T2d>; Wed, 28 Aug 2002 15:28:33 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:50934 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S318939AbSH1T2c>; Wed, 28 Aug 2002 15:28:32 -0400
Message-ID: <3D6D2537.F410B52A@nortelnetworks.com>
Date: Wed, 28 Aug 2002 15:32:07 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-6mdkenterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "=?iso-8859-1?Q?Fr=E9d=E9ric?= L.W.Meunier" <0@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECS K7S5A: IDE performance
References: <Pine.LNX.4.44.0208281611210.213-100000@pervalidus.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frédéric L. W. Meunier wrote:

> I just thought it'd be much more with an ATA100. I got more or
> less the same with my earlier motherboard, an ASUS A7APro, and
> without ATA66 - which would print a lot of CRC errors at boot
> time if enabled in the BIOS. The K7S5A doesn't print any and is
> rock solid.

If you're reading more than the size of your on-drive buffer then you'll be limited by the speed at
which the information can be grabbed off the drive--in your case, 38.1MB/s, which is quite good.

ATA33/66/100/133 only makes a significant difference in speed when you're reading from the on-drive
cache.

Chris
