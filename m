Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271001AbTG1CZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270998AbTG1AAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272953AbTG0XCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:22 -0400
Date: Sun, 27 Jul 2003 15:26:30 -0400 (EDT)
From: steven james <pyro@linuxlabs.com>
To: Jeff Dike <jdike@addtoit.com>
cc: Henrik Nordstrom <hno@marasystems.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] uml-patch-2.6.0-test1 
In-Reply-To: <200307270034.h6R0YbG8010438@uml.karaya.com>
Message-ID: <Pine.LNX.4.21.0307271522230.12132-100000@ucontrol.mobiledns.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I got networking going (at least for the switch daemon) by commenting out 
dev->hard_header = uml_net_hard_header;
in eth_configure. Might or might not be 'right', but it works anyway.

G'day,
sjames



On Sat, 26 Jul 2003, Jeff Dike wrote:

> hno@marasystems.com said:
> > As usable as the 2.4 (barring generic kernel issues) 
> 
> Generally, yes, but...
> 
> > or is there areas
> > still neeed to be looked into for the UML port to 2.6?
> 
> ... I've fallen behind on some areas, like
> 	modules
> 	hugetlbfs
> 	networking doesn't work for some reason
> 	vsyscalls and sysenter
> 	and probably a few other things which aren't coming to mind
> 
> > Any news on the possibility of having more of UML merged into the 2.6
> > tree?
> 
> Linus isn't taking my patches.  I'll give him one more try, then see if I
> can get them in through akpm.
> 
> 				Jeff
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

-- 
-------------------------steven james, director of research, linux labs
... ........ ..... ....                    230 peachtree st nw ste 2701
the original linux labs                             atlanta.ga.us 30303
      -since 1995                              http://www.linuxlabs.com
                                   office 404.577.7747 fax 404.577.7743
-----------------------------------------------------------------------


