Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSHDR3h>; Sun, 4 Aug 2002 13:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSHDR3f>; Sun, 4 Aug 2002 13:29:35 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:50448 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S316753AbSHDR3e>; Sun, 4 Aug 2002 13:29:34 -0400
Message-Id: <200208041733.TAA19565@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "alien.ant@ntlworld.com" <alien.ant@ntlworld.com>
Cc: "Alex Davis" <alex14641@yahoo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 04 Aug 2002 19:33:02 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <1028485734.14196.45.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: 2.4.19 IDE Partition Check issue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Aug 2002 19:28:54 +0100, Alan Cox wrote:

>The Promise stuff is fixed in -ac and was exactly this issue. LBA48 is
>not supported by the earlier promise controllers. The highpoint may well
>be the same problem.

Actually, LBA48 (both PIO and DMA) is fine with all Promise controllers
except for the PDC20246.

Ciao,
  Dani


