Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbRFBS2E>; Sat, 2 Jun 2001 14:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbRFBS1y>; Sat, 2 Jun 2001 14:27:54 -0400
Received: from [62.59.153.149] ([62.59.153.149]:12418 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S262651AbRFBS1q>; Sat, 2 Jun 2001 14:27:46 -0400
Date: Sat, 2 Jun 2001 20:27:04 +0200
From: Remi Turk <remi@a2zis.com>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help is complete
Message-ID: <20010602202704.F1297@localhost.localdomain>
Mail-Followup-To: Jonathan Lundell <jlundell@pobox.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105311555250.17748-100000@weyl.math.psu.edu> <3B178E0E.A4530D47@egenera.com> <20010601145900.C12402@khan.acc.umu.se> <p05100308b73d672c7f2b@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100308b73d672c7f2b@[207.213.214.37]>; from jlundell@pobox.com on Fri, Jun 01, 2001 at 08:45:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2001 at 08:45:17AM -0700, Jonathan Lundell wrote:
> >>  It allows a general interface to the kernel that does not require new
> >>  syscalls/ioctls and can be accessed from user space without specifically
> >>  compiled programs. You can use shell scripts, java, command line etc.
> >
> >Yes, and it's also totally non standardised.
> 
> It clearly fills a need, though, and has the distinct side benefit of 
> cutting down on the proliferation of ioctls. Sure, it's non-standard 
> and a mess. But it's semi-documented, easy to use, and v. general. 
> What's the preferred alternative, to state the first question another 
> way? For any single small project/driver, creating a new fs simply 
> isn't going to happen.
> -- 
> /Jonathan Lundell.

If I understand Al Viro correctly we'll get per driver filesystems
in 2.5 (based on ramfs) which you can union-mount on /proc
(possibly using autofs) to get the current /proc tree.

Happy Hacking.

-- 
Linux 2.4.5-ac6 #1 Fri Jun 1 17:12:42 CEST 2001
