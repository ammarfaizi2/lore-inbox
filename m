Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272383AbRH3SEL>; Thu, 30 Aug 2001 14:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272384AbRH3SEA>; Thu, 30 Aug 2001 14:04:00 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:57103 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272383AbRH3SDs>; Thu, 30 Aug 2001 14:03:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Christian Armingeon <johnny@allesklar.de>
To: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: HW ethernet address problems with 8139too and 2.4.9
Date: Thu, 30 Aug 2001 20:10:40 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <15820.999163539@www56.gmx.net> <slrn9os4lf.469.kraxel@bytesex.org>
In-Reply-To: <slrn9os4lf.469.kraxel@bytesex.org>
MIME-Version: 1.0
Message-Id: <01083020104000.00903@gundi>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 30. August 2001 12:17, Gerd Knorr wrote:
> Hans-Christian Armingeon wrote:
> >  Hi gurus,
> >  I've got a problem with an Elitegroup K7AMA onboard rtl8139C LAN.
> >  ifconfig shows me the hardware address ff:ff:ff:ff:ff:ff. So I'm not
> >  able to get an tcp/ip connection. Under w2k professional everything
> > works fine.
> >  Any suggestions?
>
> The f*** rtl windows driver does that.  You can do:
I didn't run windows before that on the system, the processor was a "virgin"
>
> (1) stop booting windows
> (2) ifconfig eth0 hw ether ...  at a reasonable place in the boot
>     scripts
>
>   Gerd
