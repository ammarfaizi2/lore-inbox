Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSE2HWd>; Wed, 29 May 2002 03:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSE2HWc>; Wed, 29 May 2002 03:22:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54543 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313628AbSE2HWb>; Wed, 29 May 2002 03:22:31 -0400
Message-Id: <200205290719.g4T7JVY25856@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: jan.lists@cionix.de, linux-kernel@vger.kernel.org
Subject: Re: Very High Load on Disk Activity in 2.4.18 (and 2.4.18-pre8)
Date: Wed, 29 May 2002 10:21:20 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020525121737Z314546-22651+55555@vger.kernel.org> <1022329607.3cef83072437b@mail.cionix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2002 10:26, jan.lists@cionix.de wrote:
> Hello,
>
> I'm experiencing a strange effect. As soons as there is some higher disk
> activity (untarring the linux kernel is enough, which really should be no
> problem) the system load gets really high (some times over 10) but the CPU
> is 100% idle (reported by top).

Which processes aren't sleeping? Look for STAT values other than 'S'
and/or type 'i' to switch top into no-idle mode.
--
vda
