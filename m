Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265212AbRGAQrm>; Sun, 1 Jul 2001 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265214AbRGAQrd>; Sun, 1 Jul 2001 12:47:33 -0400
Received: from rillanon.amristar.com.au ([202.181.77.23]:45581 "HELO
	amristar.com.au") by vger.kernel.org with SMTP id <S265212AbRGAQrU>;
	Sun, 1 Jul 2001 12:47:20 -0400
From: "Daniel Harvey" <daniel@amristar.com.au>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: <linux-laptop@mobilix.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Date: Mon, 2 Jul 2001 00:50:27 +0800
Message-ID: <NEBBJDBLILDEDGICHAGACENHCFAA.daniel@amristar.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
In-Reply-To: <20010702044252.B14170@weta.f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris/Adam/Mark,

Have just sucked down the SRPM of the kernel that sees to run OK. As per you
suggestions, checking out the config and patches ...

Thanks,
Daniel.

> -----Original Message-----
>
>
> Download the source-RPM for the 'fast' kernel, and also the virgin
> version of the same kernel, and then diff them to see what changes
> have been made.
>
> If you are lucky, the RPM itself my have the virgin data and diffs, I
> don't know much about RPMS, but I'm pretty sure this is possible.
>
>
> You are looking for changes outside of linux/drivers/, probably in
> linux/archo/i386 or linux/kernel. Hopefully there aren't too many of
> these.
>
> Also, you want the .config file that was used, try using that against
> a virgin kernel first, and see if that changes anything, if not, then
> do diff the above (diff -Nur virgin-kernel/ redhat-kernel/) and see
> what falls out.
>
>

