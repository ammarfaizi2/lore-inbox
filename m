Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263562AbREYGDs>; Fri, 25 May 2001 02:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263560AbREYGDi>; Fri, 25 May 2001 02:03:38 -0400
Received: from vitelus.com ([64.81.36.147]:4875 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S263559AbREYGDb>;
	Fri, 25 May 2001 02:03:31 -0400
Date: Thu, 24 May 2001 23:03:21 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010524230321.B23155@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105250559.f4P5x80365151@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 01:59:08AM -0400, Albert D. Cahalan wrote:
> If a driver writes 0x63f30e44 (4 bytes) to the card, no problem?
> Fine, how about 0x52e590a84fc8231e (8 bytes) then? You can see
> where this is leading I hope: 200 kB is perfectly fine.

Yes, I thought this way at first. However, the GPL is actually quite
explicit about defining source code:
	The source code for a work means the preferred form of the work for
	making modifications to it.

That means that if you modify your string of bytes in a hex editor,
it's not a problem. But if (as in the case of firmware) you create the
strings from secret, undistributed source files, then according to the
GPL the strings are not source code. Since the source code is
unavailable, that makes them non-free. You can see where this leads...
