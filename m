Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274968AbTHPVmn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274975AbTHPVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 17:42:43 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56450 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S274968AbTHPVml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 17:42:41 -0400
Date: Sat, 16 Aug 2003 22:42:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Valdis.Kletnieks@vt.edu
Cc: Michael Frank <mhf@linuxmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030816214237.GB25483@mail.jlokier.co.uk>
References: <200308170410.30844.mhf@linuxmail.org> <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 17 Aug 2003 04:10:30 +0800, Michael Frank <mhf@linuxmail.org>  said:
> > Linux logs almost everything, why not exceptions such as SIGSEGV
> > in userspace which may be very informative?
> 
> [SIG_IGN]

Presumably only SIGSEGVs which kill a process would be logged...

Some programs actually _use_ SIGSEGV in a useful way, to manage memory.
Same for SIGBUS and other signals.  It would be wrong to log them.

-- Jamie
