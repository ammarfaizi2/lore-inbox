Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291148AbSCOLnd>; Fri, 15 Mar 2002 06:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291251AbSCOLnY>; Fri, 15 Mar 2002 06:43:24 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:36532 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S291148AbSCOLnH>;
	Fri, 15 Mar 2002 06:43:07 -0500
Date: Fri, 15 Mar 2002 12:46:02 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <3C90E983.5AC769B8@ngforever.de>
Message-ID: <Pine.LNX.4.33.0203151243430.1477-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Thunder from the hill wrote:

> I also remember this been discussed anually. Making it configurable with
> a warning might be a solution, but that's nothing we could decide. Maybe
> add a config option? It night be a [DANGEROUS] one, so the guys and gals
> who might compile are warned of changing this.

It doesn't even have to be a config option - a line

/* Port used for dummy writes for I/O delays */
/* Change this only if you know what you're doing ! */
#define DUMMY_IO_PORT 0x80

in a header file would perfectly suffice.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





