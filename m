Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132158AbQKBIRg>; Thu, 2 Nov 2000 03:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132157AbQKBIRQ>; Thu, 2 Nov 2000 03:17:16 -0500
Received: from genesis.qualica.com ([196.26.55.194]:11016 "EHLO
	genesis.qualica.com") by vger.kernel.org with ESMTP
	id <S132144AbQKBIRK>; Thu, 2 Nov 2000 03:17:10 -0500
Date: Thu, 2 Nov 2000 10:16:40 +0200
From: Craig Schlenter <craig@qualica.com>
To: Hans-Joachim Baader <hjb@pro-linux.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: test10 won't boot
Message-ID: <20001102101640.A4391@qualica.com>
In-Reply-To: <3A0112C8.E7D1117C@mandrakesoft.com> <20001102075400.5D2F13DFC7F@grumbeer.hjb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001102075400.5D2F13DFC7F@grumbeer.hjb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 08:54:00AM +0100, Hans-Joachim Baader wrote:
> Jeff Garzik wrote:
> 
> > Hans-Joachim Baader wrote:
> > > test10, compiled with gcc 2.95.2, won't boot on one of my machine.
> > > It stops after the "now booting the kernel" message. Yes, I have
> > > configured Virtual Terminal and VGA text console.
> > 
> > Does it boot with the attached patch?
> 
> Nope, it doesn't. Same observation.
> 
> BTW this was the first 2.4 kernel that I tried on this machine.
> So I cannot say since when it's broken. 2.2.x works fine.

The test10pre series is where my machine (also with ALI chipset) was broken 
but Linus fixed it by guessing how some of the pirq stuff worked on the 1533 
chip so test10 final works for me. I'm guessing test9 will work for you
or that removing the pci_enable line in Jeff's patch completely might do
the job for you. Yes?

--Craig
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
