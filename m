Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTEATrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 15:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTEATrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 15:47:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3968 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262251AbTEATro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 15:47:44 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200305012003.h41K3hj1000265@81-2-122-30.bradfords.org.uk>
Subject: Re: Kernel source tree splitting
To: greearb@candelatech.com (Ben Greear)
Date: Thu, 1 May 2003 21:03:43 +0100 (BST)
Cc: b_adlakha@softhome.net (Balram Adlakha),
       76306.1226@compuserve.com (Chuck Ebbert), linux-kernel@vger.kernel.org
In-Reply-To: <3EB15946.4000506@candelatech.com> from "Ben Greear" at May 01, 2003 10:28:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> I have seven source trees on disk right now.  Getting rid off all
> >>the archs but i386 would not only save tons of space, it would also
> >>make 'grep -r' go faster and stop spewing irrelevant hits for archs
> >>that I couldn't care less about.
> 
> > 
> > I agree with you. Making different trees for different archs will make the tarball much smaller. Usually people only use one architecture and the other code lies waste. I think this has been discussed many times but It really is worth doing.
> 
> How about a script to just prune it once you download it.  That will at least fix your
> disk space & grep issue, and will not affect those of us who like to see it all.

Agreed - we don't want to obfuscate getting the whole kernel tree for
anybody who wants to - some of us have loads of bandwidth, and do
compile for multiple architectures :-).

> If you want to save download bandwidth, just use incremental diffs and/or something
> like bk or one of the cvs exports.

Even the current 2.5 source tree is downloadable during a, (long),
lunch break over ISDN, (or a very long lunch break over a 56K modem
:-) ).

John.
