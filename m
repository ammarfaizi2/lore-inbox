Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSBJLVh>; Sun, 10 Feb 2002 06:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSBJLV1>; Sun, 10 Feb 2002 06:21:27 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:30479 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289556AbSBJLVM>; Sun, 10 Feb 2002 06:21:12 -0500
Date: Sun, 10 Feb 2002 12:21:06 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre9
Message-ID: <20020210112106.GA14779@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C662264.9090207@telia.com.suse.lists.linux.kernel> <p738za122to.fsf@oldwotan.suse.de> <3C662896.4030303@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3C662896.4030303@telia.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2002, Pawel Worach wrote:

> This system has been running linux for about 2 years without any problem 
> at all, the hardware configuration has not changed one bit so i have a 
> hard time beliving this is hardware. booted back into -pre7 and 
> everything worked fine.

At Dortmund University, one of the machines I look after had a rock
solid configuration, good board (UP), no-name memory (256 MB PC-100
DIMM) and it was rock solid for almost a year, and all of a sudden,
without even being touched, it started to mess things up have processes
crash, wind itself up, uppercaps some characters and so on, corrupt its
file systems with e2fsck and so on.

Memtest86 quickly turned up that some memory line was faulty.
Regretfully, at the time that DIMM was bought, only 6 months warranty
were obligatory in Germany, so bad luck :-(

Consequence: don't buy memory which doesn't come with extended
guarantees.

So, get memtest86 onto floppy with a different computer and check the
memory of that box that crashed before claiming it's not the hardware.
(Sure, memtest86 will only find some memory problems, but still, it's
useful.)

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
