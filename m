Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282706AbRLIDqt>; Sat, 8 Dec 2001 22:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282955AbRLIDqj>; Sat, 8 Dec 2001 22:46:39 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:14241 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S282954AbRLIDq0>; Sat, 8 Dec 2001 22:46:26 -0500
Subject: Re: 2.4.14/16 load reboots
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16CoNe-0002bu-00@the-village.bc.nu>
In-Reply-To: <E16CoNe-0002bu-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Dec 2001 22:46:40 -0500
Message-Id: <1007869604.1810.0.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-08 at 15:47, Alan Cox wrote:
> > I have a DEC Venutris 5120 (Pentium 120) with a Phoenix BIOS.
> > After LILO loads and uncompresses these kernels the machine
> > reboots. I have ecountered sombody else with the same problem.
> 
> There are a set of old machines that do this sort of stuff with all 2.4.x
> kernels. Right now I don't know why. The Digital celebris has the same
> bug.
> 

I have a Venturis (same board as the PPro celebris, just no sockets and
such for the dual that the celebris offered).  There are odd problems
with this system.  However, if you aren't running certain features, any
recent kernel WILL run.

> > CONFIG_PCI_BIOS=y
> > CONFIG_PM=y
> 
> Turn both of these off
> 

Even if you can get this system to boot (again PPro Venturis) w/ APM...
don't do it.  It crashes whenever any APM feature is called.

> > CONFIG_PNP=y
> > CONFIG_ISAPNP=y
> 
> And these
> 

I am running with those enabled and everything works fine.  Again, mine
is a little newer than his pentium models.

> Let me know if that helps at all. Whats the last kernel that did work on it

Anyway, just some data points.  I believe my system is officially
Venturis GL 6200.

Trever Adams

