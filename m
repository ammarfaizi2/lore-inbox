Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTAaXwn>; Fri, 31 Jan 2003 18:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTAaXwn>; Fri, 31 Jan 2003 18:52:43 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:55058 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263342AbTAaXwn>; Fri, 31 Jan 2003 18:52:43 -0500
Date: Sat, 1 Feb 2003 01:01:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "J.A. Magallon" <jamagallon@able.es>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Perl in the toolchain
In-Reply-To: <20030131234021.GE1541@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0302010058300.9900-100000@serv>
References: <20030131133929.A8992@devserv.devel.redhat.com>
 <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu>
 <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es>
 <3E3B066B.8010905@pobox.com> <20030131234021.GE1541@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 1 Feb 2003, J.A. Magallon wrote:

> The easies way (from my point of view): write Perl::KConfig in C to do the logic
> hard work and build the big thing in perl. That will be putting a perl
> interface on top of klibc ?

You gain _nothing_ by rewritting it in perl. The backend is already a 
library and a swig interface file exists, so it's already trivial to 
generate Perl::KConfig. There is absolutely no reason to force people to 
use perl.

bye, Roman

