Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVBDJYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVBDJYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 04:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbVBDJVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 04:21:24 -0500
Received: from fdpsolutions.net4.nerim.net ([62.212.120.76]:27391 "EHLO
	gepeto.fdpsolutions.com") by vger.kernel.org with ESMTP
	id S261171AbVBDJU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 04:20:56 -0500
Subject: Re: Huge unreliability - does Linux have something to do with it?
From: Julien Banchet <julien@banchet.net>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f605020401037aa610b9@mail.gmail.com>
References: <5a2cf1f605020401037aa610b9@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 04 Feb 2005 10:20:54 +0100
Message-Id: <1107508854.2425.23.camel@dhcp0.fdpsolutions.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 04 f?rier 2005 à 10:03 +0100, jerome lacoste a écrit :
> [Sorry for the sensational title]
> 
> I have had this laptop for three years. It ran Linux (Debian unstable)
> from the start and its hardware has been very unreliable: I changed
> hard disks twice and the motherboard thrice. My DVD drive started
> failing some days ago (this one is 'original', 3 years old). But I
> don't mind as I am not under warranty anymore... This morning the
> machine booted with fsck errors on my hard disk. I am not sure if I
> did the right thing, but I said clear the inodes, and I ended up
> loosing some programs(*) (du, dircolors, etc..). The day starts well
> isn't it? Sounds like I will have to switch disks again...
> 
> I halted the machine correctly yesterday night. I never dropped the
> box in 3 years. Am I just being unlucky? Or could the fact that I am
> using Linux on the box affect the reliability in some ways on that
> particular hardware (Dell Inspiron 8100)? I run Linux on 3 other
> computers and never had single problems with them.
> 
> How can the file system (ext3) be messed up the way it was this
> morning after I stopped the machine correctly yesterday?
> Could a hardware failure look like bad sectors to fsck?
> 
> Attached the output of smartctl -a /dev/hda, whatever that helps.
> 
> Jerome
> 
> (*) I accept tips on discovering and maybe recovering which files have
> been taken out of my system...

I honestly beleive that your simply out of luck, not that 3 years is
alot for a laptop, but simply the "shit happens" thing.

Even though the Distro you run is tagged "Unstable" I'd rather run a
battery of stress tools on your computer it before posting here, 'cus
it's maybe a bit beyond the scope of lkml (I bet you tried more than one
versions of the kernel in 3 years, problems never remain too long, I
also hope you tried fresh installs too).

I don't think that en Inspiron 8100 carries anything exotic, so ...
well... Go for a memtest86 then try disk stress tools (my memory wen't
blank right now, ask google ;-) )


JB,
PS: Heu Jérome.... BTS Info Indus à l'Isle sur la Sorgue ?

-- 
Julien Banchet <julien@banchet.net>

