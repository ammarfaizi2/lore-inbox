Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSE1RcK>; Tue, 28 May 2002 13:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316858AbSE1RcJ>; Tue, 28 May 2002 13:32:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13310 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316856AbSE1RcG>;
	Tue, 28 May 2002 13:32:06 -0400
Date: Tue, 28 May 2002 12:31:07 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Michael Sinz <msinz@wgate.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] POSIX personality
Message-ID: <66450000.1022607067@baldur.austin.ibm.com>
In-Reply-To: <3CF3BDC4.8030401@wgate.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 28, 2002 01:26:28 PM -0400 Michael Sinz <msinz@wgate.com>
wrote:

>> I've been thinking along those lines myself.  At this point I'd suggest
>> we implement them as separate, then if in the future no one ever uses
>> them separately we can consider combining them.  I know this can raise
>> some backward compatibility issues but in theory if anyone cares we
>> wouldn't do it.
> 
> I would be worried about the future compatibility here.  It would be
> easier to be compatible to start with a single bit and then add
> individual bits for those features that need to be broken out when it is
> know to be needed. Folding the bits back in is not as easy as you now
> have to still support the individual but yet unneeded.

That's a good point.  But at this point I don't see any items where we can
say up front that everyone will want all or none of them.  I suspect we'll
just have to live with them as separate flags.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

