Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbSJVNB1>; Tue, 22 Oct 2002 09:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSJVNB1>; Tue, 22 Oct 2002 09:01:27 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:5305 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262512AbSJVNB0>; Tue, 22 Oct 2002 09:01:26 -0400
Subject: Re: problem opening multiple pipes with pipe(2) in 2.4.1[78]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug McNaught <doug@mcnaught.org>
Cc: sean finney <seanius@seanius.net>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3iszur6dw.fsf@varsoon.wireboard.com>
References: <20021021213220.A26136@sccs.swarthmore.edu>
	<3DB4B517.1070906@redhat.com> <20021022003925.A15745@sccs.swarthmore.edu> 
	<m3iszur6dw.fsf@varsoon.wireboard.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 14:23:14 +0100
Message-Id: <1035292994.31917.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 13:43, Doug McNaught wrote:
> sean finney <seanius@seanius.net> writes:
> 
> > right.  the perror() giving nonsensical results wasn't the cause of my
> > problem of course, i was just trying to use it to find out why the pipe
> > didn't seem to work.  turns out that i missed the forest for the trees;
> > the pipe was being opened for writing from the wrong end...
> > 
> > (as a side note, the code in question was written on a solaris box, and
> > it seems to Just Work in the wrong direction there, go fig.)
> 
> SysV pipes are bidirectional.

Only on later SYS5 8)

