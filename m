Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264044AbRFERKr>; Tue, 5 Jun 2001 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264046AbRFERKh>; Tue, 5 Jun 2001 13:10:37 -0400
Received: from eagle.verisign.com ([208.206.241.105]:9449 "EHLO
	eagle.verisign.com") by vger.kernel.org with ESMTP
	id <S264044AbRFERKV>; Tue, 5 Jun 2001 13:10:21 -0400
From: slurn@verisign.com
Message-Id: <200106051710.KAA03726@slurndal-lnx.verisign.com>
Subject: Re: strange network hangs using kdb
To: kaos@ocs.com.au (Keith Owens)
Date: Tue, 5 Jun 2001 10:10:14 -0700 (PDT)
Cc: jjasen1@umbc.edu (John Jasen), linux-kernel@vger.kernel.org,
        kdb@oss.sgi.com
In-Reply-To: <19199.991759088@ocs3.ocs-net> from "Keith Owens" at Jun 06, 2001 02:38:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, 5 Jun 2001 12:20:25 -0400, 
> John Jasen <jjasen1@umbc.edu> wrote:
> >On Wed, 6 Jun 2001, Keith Owens wrote:
> >> On Tue, 5 Jun 2001 11:20:26 -0400,
> >> John Jasen <jjasen1@umbc.edu> wrote:
> >> >When we use kdb on one of the systems, the other system stops receiving
> >> >packets.
> >>
> >> man linux/Documentation/kdb/kdb.mm, section Interrupts and KDB.
> >
> >I would expect one system to fall off the network, when it is put into
> >kdb. However, why does it have any effect on the other system, which may
> >or may not be in kdb?
> 
> It does not.  kdb is intrusive when it trips but even it cannot reach
> across a network and stop another machine.  Look for a networking
> problem on the other system.
> 

Might the machine running kdb also be acting as a gateway or router
for the other boxen?  This would account for the lack of connectivity.

scott
