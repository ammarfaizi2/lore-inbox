Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSEMQZn>; Mon, 13 May 2002 12:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSEMQZl>; Mon, 13 May 2002 12:25:41 -0400
Received: from [195.137.26.28] ([195.137.26.28]:56214 "EHLO
	shami.gointernet.co.uk") by vger.kernel.org with ESMTP
	id <S314106AbSEMQZ1>; Mon, 13 May 2002 12:25:27 -0400
Message-ID: <3CDFE8DC.1090803@gointernet.co.uk>
Date: Mon, 13 May 2002 17:25:00 +0100
From: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: "John O'Donnell" <johnnyo@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com> <3CDF1F1B.1090302@mindspring.com> <20020513104615.A10664@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

> Ok, if you want your fs back, correct way is to download latest preversion of
> reiserfsprogs (reiserfsprogs-3.x.1c-pre4 for now) from namesys.com ftp site,
> build it somewhere, boot off rescue media of some kind, and then run
> reiserfsck with --rebuild-tree argument (and a path to your partition of

Sorry to bother you, but are you sure you spelled it correctly? The 
latest I could find was 3.x.1c-pre3 on the namesys ftp server.
I have the same problem on a machine (made worse by the fact that the 
filesystem was a RAID0 partition).
I keep getting "wrong superblock", even after I told reiserfsck to 
rebuild the superblock.
I won't pretend I know much about filesystems, so - is my situation 
hopeless? (meaning, does RAID mess things up even worse?) Am I doing 
something wrong? Is there a difference between -pre3 and -pre4 which 
might change the response of --rebuild-tree?

Thanks for any help

Eugenio

