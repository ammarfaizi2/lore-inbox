Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315157AbSDWLWP>; Tue, 23 Apr 2002 07:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315159AbSDWLWO>; Tue, 23 Apr 2002 07:22:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:29203 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315157AbSDWLWN>; Tue, 23 Apr 2002 07:22:13 -0400
Message-Id: <200204231118.g3NBIvX15310@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Frank Louwers <frank@openminds.be>
Subject: Re: BUG: 2 NICs on same network
Date: Tue, 23 Apr 2002 14:21:23 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020423113935.A30329@openminds.be> <200204231102.g3NB2aX15231@Port.imtp.ilyichevsk.odessa.ua> <20020423131110.A2009@openminds.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2002 09:11, Frank Louwers wrote:
> > > Is this a bug or a known issue? If it is not a bug, how can it be
> > > solved?
> >
> > Do you have ip forwarding enabled? If yes, kernel just forwards packets:
> > network -> eth0 -> kernel
> >
> > Try traceroute to eth1' ip. Examine arp tables. What MAC is listed there
> > for eth1 IP?
>
> ipforwarding is disabled, arp proxy is disabled.
>
> The mac address is that of eth0 ...

Kernel bug I think. Sorry can't help you here.
I'm afraid you have to dig deeper...
--
vda
