Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSIJULa>; Tue, 10 Sep 2002 16:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSIJUL3>; Tue, 10 Sep 2002 16:11:29 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:58611
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317858AbSIJUL3>; Tue, 10 Sep 2002 16:11:29 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0209101626350.1519-100000@duckman.distro.conectiva>
References: <Pine.LNX.4.44L.0209101626350.1519-100000@duckman.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 21:18:09 +0100
Message-Id: <1031689089.31554.132.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 20:27, Rik van Riel wrote:
> On Tue, 10 Sep 2002, Linus Torvalds wrote:
> 
> > So I claim a BUG() that locks up the machine is useless. If the user
> > can't just run ksymoops and email out the BUG message, that BUG() is
> > _not_ fine on SMP.
> 
> Agreed.  Along those same lines, it would be nice if the kernel
> could spit out symbolic names so the user can't screw up the
> backtrace and we've got a better chance of extracting a useful
> bug report from our users ;)

There is a patch for this. However its fairly useless since all the
users are in X11 and while -ac will give you morse as well thats not
terribly friendly.

There are some real mode patches that try and get you back into a sane
video mode and dump you into a saner environment.

