Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271905AbRIQRN0>; Mon, 17 Sep 2001 13:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271906AbRIQRNR>; Mon, 17 Sep 2001 13:13:17 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:41479 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271905AbRIQRNE>; Mon, 17 Sep 2001 13:13:04 -0400
Message-ID: <3BA62F35.86B5F099@zip.com.au>
Date: Mon, 17 Sep 2001 10:13:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ahmedg@dacafe.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 3com 575 on Sony PCG-F590
In-Reply-To: <1000733749.mailspinnerdV3.2.5.3@smtp.dacafe.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahmedg@dacafe.com wrote:
> 
> Hello all,
> 
> I have a vaio PCG-F590 with 3Com Megahertz cardbus model 3CCFE575CT, I
> tried to install linux 2.4.4-4GB but unfortunately I couldn't configure
> it correctly.
> 
> It works if I eject the card during booting and insert it again.
> 
> Does anybody know a solution for it?
> 

There seems to be a problem specific to the 575's wherein the
cardbus layer fails to allocate the PCI IO resources correctly.
I don't have the hardware and I have yet to pin down someone
who has the time/knowledge to poke into the PCI layer to find
out what's going on.

Could you please boot the system with the card inserted, and then
send me the output of `dmesg'?

Thanks.
