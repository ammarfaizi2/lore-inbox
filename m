Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSCOMpJ>; Fri, 15 Mar 2002 07:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSCOMpA>; Fri, 15 Mar 2002 07:45:00 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:19133 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S288019AbSCOMov>;
	Fri, 15 Mar 2002 07:44:51 -0500
Date: Fri, 15 Mar 2002 13:47:39 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Andi Kleen <ak@suse.de>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <p73lmcuyrov.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0203151347110.1477-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Mar 2002, Andi Kleen wrote:

> > It doesn't even have to be a config option - a line
> >
> > /* Port used for dummy writes for I/O delays */
> > /* Change this only if you know what you're doing ! */
> > #define DUMMY_IO_PORT 0x80
> >
> > in a header file would perfectly suffice.
>
> That effectively already exists. You just need to change the __SLOW_DOWN_IO
> macro in include/asm-i387/io.h

No, that doesn't cover all accesses to port 80. I am still searching.

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





