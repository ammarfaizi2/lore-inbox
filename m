Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSEGIHd>; Tue, 7 May 2002 04:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315380AbSEGIHc>; Tue, 7 May 2002 04:07:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14858 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313558AbSEGIHb>;
	Tue, 7 May 2002 04:07:31 -0400
Message-ID: <3CD78BDC.B6ED1BA5@zip.com.au>
Date: Tue, 07 May 2002 01:10:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kees Bakker <kees.bakker@altium.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c59x: LK1.1.17 gives No MII transceivers found
In-Reply-To: <sik7qgo2x2.fsf@koli.tasking.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Bakker wrote:
> 
> In 2.5.8 there was an update of the 3c59x driver. I have two NICs,
> both use this driver, a 3c900 Boomerang and a 3c905C Tornado.
> 
> Linux 2.4.17 and 2.5.7 both report
> 00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.16
> 00:09.0: 3Com PCI 3c905C Tornado at 0xd000. Vers LK1.1.16
> 
> However, the new driver produces:
> 00:08.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd400. Vers LK1.1.17
> phy=0, phyx=24, mii_status=0xffff
> phy=1, phyx=0, mii_status=0xffff

It's just random debug code.  Does the 3c900 actually work correctly?

-
