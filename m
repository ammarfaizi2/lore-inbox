Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318152AbSHDRa2>; Sun, 4 Aug 2002 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318163AbSHDRa1>; Sun, 4 Aug 2002 13:30:27 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:55056 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S318152AbSHDRa0>; Sun, 4 Aug 2002 13:30:26 -0400
Message-Id: <200208041733.TAA19750@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Alex Davis" <alex14641@yahoo.com>,
       "alien.ant@ntlworld.com" <alien.ant@ntlworld.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 04 Aug 2002 19:33:55 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <1028485394.14195.41.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: 2.4.19 IDE Partition Check issue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Aug 2002 19:23:14 +0100, Alan Cox wrote:

>On Sun, 2002-08-04 at 16:58, Daniela Engert wrote:
>> ALi IDE controllers up to revision C4h don't support LBA48 in DMA mode,
>> later revisions can do both PIO and DMA with LBA48 addressing. Check
>> out ALi's Windows drivers to see how the manufacturer itself worked
>> around this problem (it's kinda obvious).
>
>Ok I've disabled LBA48 for revisions < 0xC4 lets see if that helps

Better make that <= 0xC4.

Ciao,
  Dani


