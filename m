Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSCBA6s>; Fri, 1 Mar 2002 19:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310225AbSCBA6i>; Fri, 1 Mar 2002 19:58:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7175 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310224AbSCBA60>;
	Fri, 1 Mar 2002 19:58:26 -0500
Message-ID: <3C8023B2.FB6ADCB9@mandrakesoft.com>
Date: Fri, 01 Mar 2002 19:58:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c509 Power Management (take 2)
In-Reply-To: <Pine.LNX.4.44.0203010826180.26745-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0203011222010.31530-100000@netfinity.realnet.co.sz> <20020301093317.I22608@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Mar 01, 2002  12:24 +0200, Zwane Mwaikambo wrote:
> > -static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE "becker@scyld.com\n";
> > +static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE " becker@scyld.com\n";
> >  static char versionB[] __initdata = "http://www.scyld.com/network/3c509.html\n";
> 
> Should this still be reporting becker@scyld.com if you guys are now
> maintaining it?  This is doubly true of the URL, since that URL will
> not have the driver that is in the kernel.

I leave it in there mainly for two reasons,
first, for several drivers, it lets people know the base version upon
which the driver was based.  This is useful if someone wanted to do some
merging of a more recent Becker version, and
second, as a courtesy, since typically the code in the driver is still
well over 60% Becker's even after all the Linus-tree modifications.

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
