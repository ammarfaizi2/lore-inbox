Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSEPGU7>; Thu, 16 May 2002 02:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSEPGU6>; Thu, 16 May 2002 02:20:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12296 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316587AbSEPGU5>; Thu, 16 May 2002 02:20:57 -0400
Message-Id: <200205160618.g4G6I5Y16037@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: No Network after Compiling,2.4.19-pre8 under Debian Woody(Long Message)
Date: Thu, 16 May 2002 09:20:36 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox> <000f01c1fc45$ff2d0cd0$2000a8c0@metalbox> <1021480696.17761.11.camel@bip>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2002 14:38, Xavier Bestel wrote:
> Yes, it works at 10Mbit. But the driver doesn't do speed negociation, it
> doesn't even see the MII registers. However I think RTL8139 cards have
> MII registers. I quickly looked at the source but didn't see anything
> special.

Becker's diag utils say there is *no* MII in RTL8139, just something vaguely
resembling that. I have trouble persuading 8139 to work in 100mbit fdx,
it insists on half duplex. :-(
--
vda
