Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319047AbSHSULT>; Mon, 19 Aug 2002 16:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319048AbSHSULT>; Mon, 19 Aug 2002 16:11:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24961 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S319047AbSHSULS>; Mon, 19 Aug 2002 16:11:18 -0400
Subject: Re: IDE?
From: "Timothy D. Witham" <wookie@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, stp@osdl.org
In-Reply-To: <200208182249.PAA01041@adam.yggdrasil.com>
References: <200208182249.PAA01041@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 13:10:46 -0700
Message-Id: <1029787846.1667.56.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Actually while we have a variety of chip sets and systems are
goal is not to have 150 different system configurations.  

  We tend to stick with multiple systems of the same type. For
example when we buy some 4 ways we buy 3 or 4 of the same one
at the same time. There are some very good reasons for this.
The 1st being trying to keep a bunch of different chip sets
and I/O controllers functioning while the development kernel
rolls forward underneath us is hard enough when you limit 
your configurations and would be impossible with 150 different
system types.  Second since we are trying to do performance
and functionality testing the ability to assign a returning
user to any one of a group of systems instead of having them
wait for the exact one they used before makes scheduling a 
lot easier. :-)

  While a large number of systems in you lab do use IDE
for at least there primary disk we really aren't trying
to provide variety for the "does this chip set work" type
of testing.

Tim


  
On Sun, 2002-08-18 at 15:49, Adam J. Richter wrote:
> On 2002-08-17, Alan Cox wrote:
> >Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
> >controllers would also be much appreciated. That way we can get good
> >coverage tests and catch badness immediately
> 
> 	From visiting the osdl.org booth a LinuxWorld, I understand
> that they have a farm of 150 deliberately differently configured
> computers on which you are supposed to be able to run your own
> kernel tests on your own kernels.
> 
> 	They have a procedure for adding new tests described at
> http://www.osdl.org/stp/HOWTO.Port_Tests.html.
> 
> 	I think it would be informative to run 2.4 ported code and
> Martin's stack against IDE tests on this system.  With this, you could
> not only spot problems, but see problems happening in a certain pattern
> which could sometimes simplify finding a bug.
> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

