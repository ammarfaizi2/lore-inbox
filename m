Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268018AbRG2O37>; Sun, 29 Jul 2001 10:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268023AbRG2O3k>; Sun, 29 Jul 2001 10:29:40 -0400
Received: from Expansa.sns.it ([192.167.206.189]:61457 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268018AbRG2O3c>;
	Sun, 29 Jul 2001 10:29:32 -0400
Date: Sun, 29 Jul 2001 16:28:56 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Chris Wedgwood <cw@f00f.org>
cc: Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Philip R. Auld" <pauld@egenera.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <20010729231023.C3917@weta.f00f.org>
Message-ID: <Pine.LNX.4.33.0107291606440.7045-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Sun, 29 Jul 2001, Chris Wedgwood wrote:

> On Sun, Jul 29, 2001 at 10:15:03PM +1200, Matthew Gardiner wrote:
>
>     tsk tsk tsk. A bit disappointing that Vertias has taken that approach.
>     However, even still, reiserFS is pretty awsome. Extremely fast and space
>     efficient, esp on a 60gig drive ;)
>
> Why "tsk tsk tsk" ?  If reiserfs suits you, use it --- you need never
> go near VXFS.
It depends, for example if you have to manage a farm (let's say 800
systems) with many Unixes
around, where solaris is the 70% of your installed basis, then
veritas (mainly the VM) could be a solution to keep an uniform
environment. That is a good thing if your sysadmin staff is composed also
by people without a real high skill.
>
> Personally, even though I use reiserfs, I am of the opinion that XFS,
> and VXFS and both superior, especially when you include volume
> management.
a journaling filesystem and a volume manager are two complementary
and usefull things, but anyway are  different things.
While i do agree that Linux LVM is still not complitelly usable in a
production environment, (but anyway ELVM from IBM is somehow immmature),
and some details of its design are not completely, how can I say...,
suitable for future HW developments, I found reiserFS tecnology to be
really interesting. On a technological point of view reiserFS is much
more advanced in front of any other journaled FS around.

I still have to see vxfs with Linux, but i saw it under solaris and HP-UX
(i think I used all journaled aroung, jfs, xfs, reiserFS, ext3, vxfs, gfs,
on all unixes i could), seeing it to too much slow on high end scsi HW,
and XFS on my origin 2000 (8 processor) sometimes takes one CPU just to
manage journaling under heavy I/O. Under Linux xfs is maybe better that
under Irix (!!!???), but its tecnology was thinked for other kind of HW,
and an experienced sysadmin can "feel" this.
> Time will show whether or not these very well designed
> file-systems are suitable under Linux though, as reiserfs has a
> considerable head start.
Yes, time will show. reiserFS can have a wonderfull future, better than
ext3 if it will be mature before ext3, worse if after. But for Linux
jfs and xfs are interesting right now, just untill native journaled will
be ready, then i would bet everyone will stay with reiserFS or ext3, not
considering any other solution.

Luigi


