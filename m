Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRGNRaB>; Sat, 14 Jul 2001 13:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRGNR3u>; Sat, 14 Jul 2001 13:29:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60323 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264329AbRGNR3i>;
	Sat, 14 Jul 2001 13:29:38 -0400
Message-ID: <3B50817B.37FE29@mandrakesoft.com>
Date: Sat, 14 Jul 2001 13:29:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
In-Reply-To: <E15LSoA-0001Sj-00@the-village.bc.nu> <20010715051134.A7056@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh cool, thanks.  This saves me some work.  I originally did a lot of
the cleanup in 2.4 to get rid of malloc.h references, but specifically
didn't touch much arch/* at the time.

tangent, it would be nice to remove __KERNEL__ from at least the i386
kernel headers in 2.5, and I think it's a doable task...

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
