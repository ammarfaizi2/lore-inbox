Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTI2LYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTI2LYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:24:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:45696 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263121AbTI2LYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:24:45 -0400
Date: Mon, 29 Sep 2003 12:24:47 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309291124.h8TBOlam000872@81-2-122-30.bradfords.org.uk>
To: Rob Landley <rob@landley.net>, Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309290356.27600.rob@landley.net>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
 <20030925122838.A16288@discworld.dyndns.org>
 <20030925182921.GA18749@work.bitmover.com>
 <200309290356.27600.rob@landley.net>
Subject: Re: log-buf-len dynamic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BK is really just a merging tool that fixes rejects 
> automatically, everything else is details...

IFF that is true, then taking this to it's logical extreme, what is
the point in having an SCM system for kernel development at all?

It could be argued that what we really need is enhanced versions of
diff and patch that actually understand C constructs and are able to
make intellegent decisions about merging two pieces of code, even
without knowledge of other merges.

'Enhanced' is, of course, a complete understatement.  What I am
suggesting is basicaly adding A.I. functionality to diff and patch, to
the point where they can merge three pieces of C code as efficiently
as a good developer can.

This would probably involve analysing code and identifying discrete
sections, (analogous to the way a human developer would draw a flow
chart), within which the purpose of algorithms and variable names
could be deduced.  This knowledge could then be used to adapt code
that was submitted as a diff against a compltely different piece of
code.

Ultimately, it should be possible for two people to independently
write code to do a certain task, for one of them to add an extra
facility to their codebase, and for the enhanced diff and patch tools
to then add this facilty to the other, completely separate,
implementation.

John
