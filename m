Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbTC1ShE>; Fri, 28 Mar 2003 13:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263087AbTC1ShE>; Fri, 28 Mar 2003 13:37:04 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:23565 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263083AbTC1ShD>; Fri, 28 Mar 2003 13:37:03 -0500
Date: Fri, 28 Mar 2003 19:48:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Joel Becker <Joel.Becker@oracle.com>
cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <Andries.Brouwer@cwi.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030328180545.GG32000@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0303281924530.5042-100000@serv>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk>
 <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com>
 <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Mar 2003, Joel Becker wrote:

> 	I represent the users which need this most, and I an tell you we
> will be 100x happier pointing and guessing at enough dev_t space.  If we
> were to have to stick with the ancient, serously outdated limits of the
> current space, we will be terribly unhappy.
> 	Not having the perfect solution all at once doesn't mean you do
> nothing.  The size of dev_t is orthogonal to device naming.  Once this
> is in, the current device naming (however poor it is) can handle the
> number of devices we need.  Future device naming strategies (like the
> one Greg is working on) will work with a large dev_t just fine.

I don't mind temporary solutions, but I prefer the ones, which don't have 
to be thrown away completely (e.g. like Andries char device changes).
If Andries would actually explain, what he wants to do with the larger 
dev_t, it would be a lot easier to help him, so that we can at least avoid 
the biggest mistakes.

bye, Roman

