Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSFNRKA>; Fri, 14 Jun 2002 13:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSFNRJz>; Fri, 14 Jun 2002 13:09:55 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12460 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S310190AbSFNRJw>;
	Fri, 14 Jun 2002 13:09:52 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 14 Jun 2002 19:09:40 +0200 (MEST)
Message-Id: <UTC200206141709.g5EH9eG29898.aeb@smtp.cwi.nl>
To: axboe@suse.de, dalecki@evision-ventures.com
Subject: Re: [PATCH] 2.5.21 IDE 91
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frankly, _I'm_ too scared to run 2.5 IDE currently.

Backups, that is what you need. Or a scratch machine.

This is what vanilla 2.5.21 can do to your filesystem
(after a reboot and a e2fsck -a):

% ls /lost+found
#10416
#104719
#104724
#10537
#10540
#10547
#10548
#10549
#10550
#10551
#106768
#108545
#108550
#108576
...
(thousands and thousands of files - not lost, only their
names suffered a bit...)

But, to be fair, only a small part of the damage is due
to the kernel. Afterwards, e2fsck made things much worse.

Andries


(Vanilla 2.5.21 does not compile, you say?
OK, 2.5.21 together with the addition of the #include lines
that make it compile.)
