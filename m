Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136461AbRD3G6o>; Mon, 30 Apr 2001 02:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136462AbRD3G6f>; Mon, 30 Apr 2001 02:58:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55445 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136461AbRD3G60>;
	Mon, 30 Apr 2001 02:58:26 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.3340.784923.77844@pizda.ninka.net>
Date: Sun, 29 Apr 2001 23:58:20 -0700 (PDT)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Ralf Nyren <ralf@nyren.net>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
In-Reply-To: <3AED0A7A.7263E27B@uow.edu.au>
In-Reply-To: <Pine.LNX.4.31.0104291552190.523-100000@HADDOCK.100Mbit.nyren.net>
	<15084.62398.56283.772414@pizda.ninka.net>
	<3AED0A7A.7263E27B@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > "David S. Miller" wrote:
 > > 
 > > I'm having a devil of a time finding the tcpblast sources on the
 > > net, can you point me to where I can get them?
 > 
 > I seem to have a copy. 
 > 
 > http://www.zip.com.au/~akpm/tcpblast-19990504.tar.gz

Thanks to everyone who pointed me at this and the debian copy :-)

Anyways, I just tried to reproduce Ralf's problem on two of my
machines.  One was an SMP sparc64 system, and the other was my
uniprocessor Athlon.

What kind of machine are you reproducing this on Ralf?  I'm not
even getting the very strange errors from tcpblast on the command
line, it is functioning perfectly fine and sending a stream of
data to the other machine.  Are you doing something weird like
making the remote machine the local machine in your tcpblast run?

Later,
David S. Miller
davem@redhat.com
