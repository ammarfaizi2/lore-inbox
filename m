Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUHGDMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUHGDMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 23:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUHGDL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 23:11:59 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2]:50066 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id S266212AbUHGDLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 23:11:48 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
	<20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de>
	<20040731210257.GA22560@bliss> <20040805054056.GC10376@suse.de>
	<1091739966.8418.38.camel@localhost.localdomain>
	<20040806054424.GB10274@suse.de> <20040806062331.GE10274@suse.de>
	<1091794470.16306.11.camel@localhost.localdomain>
	<20040806143258.GB23263@suse.de>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: Fri, 06 Aug 2004 22:11:40 -0500
In-Reply-To: <20040806143258.GB23263@suse.de> (Jens Axboe's message of "Fri,
 6 Aug 2004 16:32:58 +0200")
Message-ID: <ufa4qnfzloz.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JA" == Jens Axboe <axboe@suse.de> writes:

JA> Like when dvd readers became common, you can't just require people
JA> to update their kernel because a few new commands are needed to
JA> drive them from user space.

Perhaps I'm being completely dense, but why would the filtering tables
have to be compiled into the kernel?  Why not load them from user
space via a mechanism requiring CAP_SYS_RAWIO?

How many commands are we talking about here?  Is the mechanism
workable by a simple bitmask, or is something more complex like a
state machine required?

 - J<
