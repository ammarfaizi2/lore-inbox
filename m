Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbRLWEXP>; Sat, 22 Dec 2001 23:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283390AbRLWEXG>; Sat, 22 Dec 2001 23:23:06 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:46041 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283340AbRLWEWr>;
	Sat, 22 Dec 2001 23:22:47 -0500
Date: Sun, 23 Dec 2001 03:57:52 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011223025752.GA20445@moongate.thevoid.net>
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <Pine.LNX.4.33.0112222109310.5312-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112222109310.5312-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> there is no problem with these disks or chipsets.  have you checked your
> ide cable (*always* must be 18" or less, with *both* ends plugged in)?
> also, do you have the via-specific ide driver?

the ide cable is the one that came with the mainboard, it worked perfectly
for one year with the 20gb hd. and yes, i'm using the via-driver.

the strange thing about this is that it all worked perfectly before i added
the 80gb disk. and it corrupts files only on that disk.

anyway, i've recompiled 2.4.17 from a fresh source tree. until now, i
haven't discovered any corrupted files of whoch i _know_ that they have to
be corrupted since i used this kernel. so probably this was a problem of the
preemption patch and reiserfs and large disks and via chipsets, but i'm not
100% sure about this. the changelog for 2.4.17 mentioned some reiserfs
fixes; are any of those related to corrupted files?

bye
christian ohm

