Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRKSIxs>; Mon, 19 Nov 2001 03:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276094AbRKSIxj>; Mon, 19 Nov 2001 03:53:39 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:29686 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S276249AbRKSIx3>;
	Mon, 19 Nov 2001 03:53:29 -0500
Date: Mon, 19 Nov 2001 01:52:42 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
Message-ID: <20011119015242.B1308@lynx.no>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au> <E164gCQ-0003YZ-00@the-village.bc.nu> <15352.32969.717938.153375@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <15352.32969.717938.153375@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Mon, Nov 19, 2001 at 02:47:21PM +1100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19, 2001  14:47 +1100, Neil Brown wrote:
>  - devfs puts a lot of miscellaneous stuff in the top level.
>    I would want to group them into one namespace. e.g.:
>        misc/memory/mem
>        misc/memory/kmem
>        misc/memory/zero
>        misc/memory/null
>        misc/random/random
>        misc/random/urandom

Erm, what about the millions+ of scripts/apps that reference /dev/zero
or /dev/null?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

