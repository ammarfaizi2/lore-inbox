Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276350AbRJPPz7>; Tue, 16 Oct 2001 11:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJPPzt>; Tue, 16 Oct 2001 11:55:49 -0400
Received: from mail.fbab.net ([212.75.83.8]:20746 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S276350AbRJPPzh>;
	Tue, 16 Oct 2001 11:55:37 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 6.2359 secs)
Message-ID: <007b01c1565b$0c49a450$020a0a0a@totalmef2>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <E15tUQp-0000h3-00@d101.x-mailer.de>
Subject: Re: tyan K7 thunder
Date: Tue, 16 Oct 2001 17:55:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well I can't even get it to boot some dists/kernels.

When I tried to install Peanut Linux (http://www.ibiblio.org/peanut/) it
just hangs after "Freeing unused kernel memory ( XXX K )".

It's bootdisk has a 2.4.10 kernel, and I wonder if there is any gotchas with
this version of kernel together with the AMD Athlon MP, AMD 760MP, AMD 762,
AMD 766, or tyan s2462 chips and board that produces this hang.

Magnus

----- Original Message -----
From: "Andreas Gietl" <a.gietl@e-admin.de>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, October 16, 2001 3:39 PM
Subject: tyan K7 thunder


> hi,
>
> First every thing was just fine with our new tyan k7 thunder server and we
> did some load testing and the machine ran fine for 4 weeks. But after we
> started to use it in production we had major stability problems with that
new
> Dual Athlon 1200 machine. we found tons of mails in this mailling list
about
> this configuration crashing. We tried to stabilize the SMP-kernel
(v.2.4.9)
> for 4 days w/o luck. We played around with the bios and especially the use
> pci table in MP table switch gave us a lot more stability but the machine
> still keeped on crashing every few hours with a kernel panic:
>
> kernel panic aiee, killing interrupt handler
> in interrupt handler - not syncing'
>
> We tried noapic, and all the things that were recommended. We also read
that
> Alan Cox thinks that some of these MBs simply are kind of damaged.
>
> Right now we are running this machine with v2.4.12 uniprocessor kernel and
it
> seems to be stable. What i wanna know is whether there are some
improvements
> in the support for this mainboard in the kernel from 2.4.9 to 2.4.12 so we
> could risk another try with the SMP kernel.
>
> thank you for you help
>
> andreas
>
> P.S.: The tyan support (after 5 days we were frustrated enough to call
them
> up) said the don't support Linux, and their boards are just certified for
> Windows. But of course this is not alternative for us....
> --
> e-admin internet gmbh
> Andreas Gietl
> Roter-Brach-Weg 124a
> tel +49 941 3810884
> fax +49 941 3810891
> mobil +49 171 6070008
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

