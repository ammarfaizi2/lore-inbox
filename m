Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271677AbRHQP5v>; Fri, 17 Aug 2001 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271678AbRHQP5l>; Fri, 17 Aug 2001 11:57:41 -0400
Received: from mail.internet-factory.de ([195.122.142.5]:27790 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S271681AbRHQP5c>; Fri, 17 Aug 2001 11:57:32 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: Encrypted Swap
Date: Fri, 17 Aug 2001 17:57:45 +0200
Organization: Internet Factory AG
Message-ID: <3B7D3EF9.4CEABF2C@internet-factory.de>
In-Reply-To: <3B7D2F3C.A4687E25@internet-factory.de> <Pine.LNX.3.95.1010817111201.863A-100000@chaos.analogic.com>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 998063865 4449 195.122.142.158 (17 Aug 2001 15:57:45 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 17 Aug 2001 15:57:45 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac3 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" proclaimed:

> Errrm no. All BIOS that anybody would use write all memory found when
> initializing the SDRAM controller. They need to because nothing,
> refresh, precharge, (or if you've got it, parity/crc) will work
> until every cell is exercised. A "warm-boot" is different. However,
> if you hit the reset or the power switch, nothing in RAM survives.

Then this may have changed with SDRAM. However, back in my Amiga days it
was pretty common to just reset the machine and rip whatever was left in
the memory (DRAM). If memory serves me right, some people put in reset
protection (by pointing the reset vector to some code that cleared the
memory), which could be fooled by hardware reset or power cycling.

Holger
