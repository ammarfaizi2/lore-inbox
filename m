Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268560AbRHQRzU>; Fri, 17 Aug 2001 13:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRHQRzK>; Fri, 17 Aug 2001 13:55:10 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:64970 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S268560AbRHQRy7>; Fri, 17 Aug 2001 13:54:59 -0400
Date: Fri, 17 Aug 2001 12:55:13 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext2 not NULLing deleted files?
In-Reply-To: <20010817020241.C32617@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0108171243410.392-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the need to do more than just zero unwanted data, I note that
there is a U.S. DOD MIL-SPEC (no, I do not know the number) which defines
a sequence of patterns to be used for erasing magnetic media.  VMS has a
hook on which one may hang one's own erasure pattern generator, and I
think DEC provided an unsupported implementation of the MIL-SPEC patterns
as an example of its use.  INITIALIZE /ERASE can use the patterns, but I
don't recall whether DELETE /ERASE does.  If you don't provide a
generator, I think erasure just uses zeros.

I recall hearing that highly-classified data must be destroyed by
physically shredding the medium.  Yes, throw your disk drive in the
shredder!  (Just imagine the class of machinery required to digest an RA81
HDA.)

Most of this goes way beyond the need to deter casual snooping.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

