Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314380AbSEMTFC>; Mon, 13 May 2002 15:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSEMTFB>; Mon, 13 May 2002 15:05:01 -0400
Received: from angband.namesys.com ([212.16.7.85]:44160 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S314380AbSEMTFA>; Mon, 13 May 2002 15:05:00 -0400
Date: Mon, 13 May 2002 23:05:00 +0400
From: Oleg Drokin <green@namesys.com>
To: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
Cc: "John O'Donnell" <johnnyo@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
Message-ID: <20020513230500.A1897@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com> <3CDF1F1B.1090302@mindspring.com> <20020513104615.A10664@namesys.com> <3CDFE8DC.1090803@gointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, May 13, 2002 at 05:25:00PM +0100, Eugenio Mastroviti wrote:

> >build it somewhere, boot off rescue media of some kind, and then run
> >reiserfsck with --rebuild-tree argument (and a path to your partition of
> Sorry to bother you, but are you sure you spelled it correctly? The 

I am.

> latest I could find was 3.x.1c-pre3 on the namesys ftp server.

Hm. -pre4 is not public yet, it seems.

> I have the same problem on a machine (made worse by the fact that the 
> filesystem was a RAID0 partition).
> I keep getting "wrong superblock", even after I told reiserfsck to 
> rebuild the superblock.

You mean, after the --rebuild-sb command?

What exactly have happened to your FS, BTW?

> I won't pretend I know much about filesystems, so - is my situation 
> hopeless? (meaning, does RAID mess things up even worse?) Am I doing 
> something wrong? Is there a difference between -pre3 and -pre4 which 
> might change the response of --rebuild-tree?

--rebuild-tree needs valid superblock, I think.

Bye,
    Oleg
