Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293256AbSCAQfI>; Fri, 1 Mar 2002 11:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293228AbSCAQfA>; Fri, 1 Mar 2002 11:35:00 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:52719 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S293277AbSCAQdm>;
	Fri, 1 Mar 2002 11:33:42 -0500
Date: Fri, 1 Mar 2002 09:33:17 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c509 Power Management (take 2)
Message-ID: <20020301093317.I22608@lynx.adilger.int>
Mail-Followup-To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203010826180.26745-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0203011222010.31530-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0203011222010.31530-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Fri, Mar 01, 2002 at 12:24:54PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 01, 2002  12:24 +0200, Zwane Mwaikambo wrote:
> -static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE "becker@scyld.com\n";
> +static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE " becker@scyld.com\n";
>  static char versionB[] __initdata = "http://www.scyld.com/network/3c509.html\n";

Should this still be reporting becker@scyld.com if you guys are now
maintaining it?  This is doubly true of the URL, since that URL will
not have the driver that is in the kernel.

PS - any chance you can fix this for xirc2ps_cs?  I can test if you want,
     as my current card always fails to word after APM suspend (needs a
     "cardctl eject; cardctl insert" to work again.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

