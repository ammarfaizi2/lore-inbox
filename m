Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSICQAY>; Tue, 3 Sep 2002 12:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSICQAX>; Tue, 3 Sep 2002 12:00:23 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:7943 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318798AbSICQAR>;
	Tue, 3 Sep 2002 12:00:17 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031604.g83G4fY06284@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.GSO.3.96.1020903174246.20090C-100000@delta.ds2.pg.gda.pl>
 from "Maciej W. Rozycki" at "Sep 3, 2002 05:53:39 pm"
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Date: Tue, 3 Sep 2002 18:04:41 +0200 (MET DST)
Cc: Rik van Riel <riel@conectiva.com.br>, "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Maciej W. Rozycki wrote:"
> On Tue, 3 Sep 2002, Rik van Riel wrote:
> > And what if they both allocate the same disk block to another
> > file, simultaneously ?
> 
>  You need a mutex then.  For SCSI devices a reservation is the way to go
> -- the RESERVE/RELEASE commands are mandatory for direct-access devices,
> so thy should work universally for disks.

Is there provision in VFS for this operation?

(i.e. care to point me at an entry point? I just grepped for "reserve"
and came up with nothing useful).

Peter
