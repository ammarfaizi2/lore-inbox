Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSEPJGu>; Thu, 16 May 2002 05:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316612AbSEPJGt>; Thu, 16 May 2002 05:06:49 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:32682
	"EHLO awak") by vger.kernel.org with ESMTP id <S316611AbSEPJGs> convert rfc822-to-8bit;
	Thu, 16 May 2002 05:06:48 -0400
Subject: Re: No Network after Compiling,2.4.19-pre8 under Debian Woody(Long
	Message)
From: Xavier Bestel <xavier.bestel@free.fr>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200205160618.g4G6I5Y16037@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 May 2002 11:05:53 +0200
Message-Id: <1021539953.17761.150.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 16/05/2002 à 13:20, Denis Vlasenko a écrit :
> On 15 May 2002 14:38, Xavier Bestel wrote:
> > Yes, it works at 10Mbit. But the driver doesn't do speed negociation, it
> > doesn't even see the MII registers. However I think RTL8139 cards have
> > MII registers. I quickly looked at the source but didn't see anything
> > special.
> 
> Becker's diag utils say there is *no* MII in RTL8139, just something vaguely
> resembling that. I have trouble persuading 8139 to work in 100mbit fdx,
> it insists on half duplex. :-(

How do you do this ? Mine only accepts 10Mbits ...
I tried with mii-diad and with rtl8139-diag.
rtl8139-diag shows "internal MII-compatible registers", then "Link
Partner Ability register 0x40a1" (seems what I want), but then "I'm
advertising 0000" and "Link partner capability is 0000".
I'm lost.

