Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTBIM43>; Sun, 9 Feb 2003 07:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbTBIM43>; Sun, 9 Feb 2003 07:56:29 -0500
Received: from [81.2.122.30] ([81.2.122.30]:64004 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267243AbTBIM42>;
	Sun, 9 Feb 2003 07:56:28 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302091307.h19D76wV000674@darkstar.example.net>
Subject: Re: Some Doubts About bootsect.S & Setup.S
To: borasah@netone.com.tr (=?iso-8859-9?B?Qm9yYSDeYWhpbg==?=)
Date: Sun, 9 Feb 2003 13:07:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <010f01c2d038$0dbe0c60$0100a8c0@bora> from "=?iso-8859-9?B?Qm9yYSDeYWhpbg==?=" at Feb 09, 2003 02:23:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1)
> sread:  .word 0             # sectors read of current track
> head:   .word 0             # current head
> track:  .word 0             # current track
> 
> Since a diskette can have at most 2 heads, 80 tracks and 36 sectors per
> track, why are these not bytes instead of words especially since space is at
> such a tight premium in this code?

See:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104250711526623&w=2

> Someone(H. Peter Anvin) tell me that these codes was old and broken, and was
> getting nuked in 2.5.

The in-kernel bootloader will almost certainly not be in 2.6.

Personally, I think it would be good to replace it with some kind of
monitor, but I don't think anybody else would agree with me :-)

John.
