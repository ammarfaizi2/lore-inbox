Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315546AbSENJCC>; Tue, 14 May 2002 05:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSENJCB>; Tue, 14 May 2002 05:02:01 -0400
Received: from angband.namesys.com ([212.16.7.85]:1664 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S315536AbSENJB7>; Tue, 14 May 2002 05:01:59 -0400
Date: Tue, 14 May 2002 13:01:54 +0400
From: Oleg Drokin <green@namesys.com>
To: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
Cc: "John O'Donnell" <johnnyo@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
Message-ID: <20020514130153.A817@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com> <3CDF1F1B.1090302@mindspring.com> <20020513104615.A10664@namesys.com> <3CDFE8DC.1090803@gointernet.co.uk> <20020513230500.A1897@namesys.com> <3CE0CDC8.1080000@gointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, May 14, 2002 at 09:41:44AM +0100, Eugenio Mastroviti wrote:

> >You mean, after the --rebuild-sb command?
> Yes. The first time I ran reiserfsck --rebuild-tree it told me to 
> rebuild the superblock and so I ran --rebuild-sb. The startup messages 
> only say the format is 3.5.x, so I selected the <=3.5.9 option

This is a mistake.
You need to choose other, more recent format.
It is highly unlikely you might have format of version <=3.5.9
If you have not done rebuild-tree after that again - you may do
--rebuild-sb and choose more recent format, then it should help.

> >What exactly have happened to your FS, BTW?
> A complete - and so far unexplained - system freeze. The distro is SuSE 
> 7.3, kernel 2.4.10. I have used it at home ever since it came out 

2.4.10 is way too old.

> Well, I'll be very grateful for any insight you can offer

First of all make sure that your raid array same up fully.
This is very important! Check all the partitions if they are of correct size.
Then do rebild-sb and choose more correct superblock version (if asked).
If you are not asked for the fs version, that's bad. Let us know then.

After that you might try to do --rebuild-sb and that one should help.

I see this --rebuild-sb causes a lot of confusion for people, when it asks
the format, I am going to make it to offer some hints.
Thanks for your report.

Bye,
    Oleg
