Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262470AbTCMRgP>; Thu, 13 Mar 2003 12:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbTCMRgP>; Thu, 13 Mar 2003 12:36:15 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38606
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262472AbTCMRgL>; Thu, 13 Mar 2003 12:36:11 -0500
Subject: Re: Linux BUG: Memory Leak
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       James Stevenson <james@stev.org>, pd dd <parviz_kernel@yahoo.com>,
       "M. Soltysiak" <msoltysiak@hotmail.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
In-Reply-To: <20030313151047.GA20516@mark.mielke.cc>
References: <01f901c2e96c$98b1e3d0$0cfea8c0@ezdsp.com>
	 <Pine.LNX.3.95.1030313093618.21484A-100000@chaos>
	 <20030313151047.GA20516@mark.mielke.cc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047581691.25949.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Mar 2003 18:54:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 15:10, Mark Mielke wrote:
> On Thu, Mar 13, 2003 at 09:42:39AM -0500, Richard B. Johnson wrote:
> > But it's a memory leak in the game, not the kernel. They should
> > complain to the game makers. If a game runs the system out of
> > memory so a user can't log in on the root account and kill off
> > the game, it's a problem with the game.
> 
> I would like to encourage the camp of people who believe that UNIX can
> be a stable server platform to innovate ways of ensuring that if a game
> (or other memory intensive program) does run the system out of memory,
> an administrator could login as root and kill the game.

echo "2" >/proc/sys/vm/overcommit_memory 

in a -ac kernel

