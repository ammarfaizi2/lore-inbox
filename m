Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270271AbRHRSFP>; Sat, 18 Aug 2001 14:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270274AbRHRSFF>; Sat, 18 Aug 2001 14:05:05 -0400
Received: from mail.fbab.net ([212.75.83.8]:37650 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S270271AbRHRSEz>;
	Sat, 18 Aug 2001 14:04:55 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: fred@arkansaswebs.com linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 7.608449 secs)
Message-ID: <001901c12810$97ef3a70$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Fred Jackson" <fred@arkansaswebs.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <01081812570001.09229@bits.linuxball>
Subject: Re: 2.4.xx won't recompile.
Date: Sat, 18 Aug 2001 20:07:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Fred Jackson" <fred@arkansaswebs.com>
> 
[snipi]
> 
> I start with the usual 
> make mrproper
> make xconfig ( I load a kernel config file - originally created with 
> 2.4.8) 
> make bzImage
> make modules
> make modules_install
> make install
> 
> (i've already edited lilo.conf and the links in the /boot directory)
> 

Isn't it more safe to do it like this:

make mrproper
cp ../linux-2.4.8/.config .
make oldconfig
make xconfig
make bzImage && make modules && make modules_install && make install

?
I thought this was the proper way to do it, no?

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


