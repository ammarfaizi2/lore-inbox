Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269439AbTGVEjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 00:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269528AbTGVEjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 00:39:48 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:43258 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S269439AbTGVEjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 00:39:47 -0400
To: "Charles E. Youse" <beef@nexuslabs.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, John Bradford <john@grabjohn.com>,
       <lkml@lrsehosting.com>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <lm@bitmover.com>, <rms@gnu.org>,
       <Valdis.Kletnieks@vt.edu>
Subject: Re: [OT] HURD vs Linux/HURD
References: <20030720092239.E75410-100000@treason.nexuslabs.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 22 Jul 2003 13:52:57 +0900
In-Reply-To: <20030720092239.E75410-100000@treason.nexuslabs.com>
Message-ID: <buovftv17ti.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Charles E. Youse" <beef@nexuslabs.com> writes:
> > As far as I know, HURD is using ext2fs code.  It should definitely be
> > called HURD/Linux.  :-)
> 
> My understanding is that theirs is a re-implementation of ext2, not a port.

I did the original port of ext2 to the hurd, and I definitely used the
linux code.  Of course the lowest- and highest-level interfaces are all
different, so that code was replaced, but the most important `middle' part
that actually interprets the disk contents was largely the same code
(the separation is not actually so clean in practice, of course).

This is as it should be, I think...

-Miles
-- 
80% of success is just showing up.  --Woody Allen
