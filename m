Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270255AbTG2QVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271832AbTG2QUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:20:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23683 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271898AbTG2QTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:19:53 -0400
Date: Tue, 29 Jul 2003 17:19:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The well-factored 386
Message-ID: <20030729161951.GA15889@mail.jlokier.co.uk>
References: <03072809023201.00228@linux24> <20030728093245.60e46186.davem@redhat.com> <20030728194127.GA10673@mail.jlokier.co.uk> <20030729111423.GA5320@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729111423.GA5320@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> > The one thing that made it on-topic for me was his quiet suggestion
> > that "forreal" mode interrupts are faster, and that it might, perhaps,
> > be possible to modify a Linux kernel to run in that mode - to take
> > advantage of the faster interrupts.
> 
> That would have to be a kernel for very special use.  The "forreal"
> mode has protection turned off.  As far as I know, that
> means any user process can take over the cpu as if
> it was running in kernel mode.

There are quite a few embedded systems where that is ok, especially if
performance is improved.

Also, I am not sure whether paging still works in "forreal" mode.  If
it does, kernel memory could still be protected.  Not well enough for
security, but enough to protect against programming errors.

-- Jamie
