Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287531AbSAOQax>; Tue, 15 Jan 2002 11:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287950AbSAOQae>; Tue, 15 Jan 2002 11:30:34 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:6534 "EHLO e22.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S287531AbSAOQaZ>;
	Tue, 15 Jan 2002 11:30:25 -0500
Message-ID: <3C44A79A.6317B059@in.ibm.com>
Date: Tue, 15 Jan 2002 17:05:14 -0500
From: Suparna Bhattacharya <suparna@in.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
CC: "SATHISH.J" <sathish.j@tatainfotech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux india programming 
	<linux-india-programmers@lists.sourceforge.net>
Subject: Re: How to take a crash dump
In-Reply-To: <Pine.LNX.4.10.10201041427001.2221-100000@blrmail> <20020114211408.GB21480@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Fri, Jan 04, 2002 at 02:30:20PM +0530, SATHISH.J wrote:
> > I have "lcrash" installed on my system. I have 2.4.8 kernel. I would like
> > to know how to make a linux system panic so that I can take a crash dump
> > and analyse using "lcrash". Is there any command to make the system panis
> > as we have on other unices(SVR4 and unixware)?
> 

Have you tried using the Alt+Sysrq+c key combination ? 

We had checked in some changes to enable non-disruptive dumps to be
taken this way as 
well (i.e. you can get a dump without having to reboot the system) but
that piece is going to be in lkcd 4.01. 

BTW, you can also trigger a crash dump conditionally using dprobes.

Regards
Suparna

> I wrote a toy module that does exactly what you want:
> 
>   http://www.lart.tudelft.nl/lartware/port/lart.c
> 
> I still have to get the module into Linus' tree so Christoph Hellwig
> will drive to .nl to buy me a beer :)
> 
> Erik
> 
> --
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
> of Information Technology and Systems, Delft University of Technology,
> PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
> Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
