Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132632AbQKSRG4>; Sun, 19 Nov 2000 12:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132622AbQKSRGr>; Sun, 19 Nov 2000 12:06:47 -0500
Received: from hera.cwi.nl ([192.16.191.1]:39621 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S132632AbQKSRGe>;
	Sun, 19 Nov 2000 12:06:34 -0500
Date: Sun, 19 Nov 2000 17:36:23 +0100
From: Andries Brouwer <aeb@veritas.com>
To: linux-kernel@vger.kernel.org
Cc: ahu@ds9a.nl, goemon@anime.net
Subject: Re: 2.4 sendfile() not doing as manpage promises?
Message-ID: <20001119173623.A1185@veritas.com>
In-Reply-To: <20001119001558.B10579@home.ds9a.nl> <Pine.LNX.4.30.0011181513290.5897-100000@anime.net> <20001119015259.A10773@home.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001119015259.A10773@home.ds9a.nl>; from ahu@ds9a.nl on Sun, Nov 19, 2000 at 01:53:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 01:53:00AM +0100, bert hubert wrote:
:  On Sat, Nov 18, 2000 at 03:15:28PM -0800, Dan Hollis wrote:
:  
:::  In that case, the wording of the manpage needs to be changed, as it
:::  implies that 'either or both' of the filedescriptors can be sockets.
::  
::  Its quite clear.
::  
::  DESCRIPTION
::         This  call copies data between file descriptor and another
::         file  descriptor  or  socket.   in_fd  should  be  a  file
::         descriptor   opened  for  reading.   out_fd  should  be  a
::         descriptor opened for writing or a connected socket.
::  
::  in_fd must be a file, out_fd can be a file or socket.
:  
:  My manpages must be outdated then, my manpage is from 1 Dec 1998. Thanks for
:  the correction.

The manpage is dated 1 Dec 1998 and reads

DESCRIPTION
       This call copies data  between  one  file  descriptor  and
       another.   Either  or  both  of these file descriptors may
       refer to a socket.  in_fd  should  be  a  file  descriptor
       opened  for  reading  and  out_fd  should  be a descriptor
       opened for writing.

If that is incorrect, then editing a private copy of the manpage,
as Dan Hollis, or the distributor from whom he got his page,
seems to have done, does not suffice to change the manpage distribution.

(Moreover, the text Dan Hollis quotes is rather strange --
also sockets give one a file descriptor, so the author
of that modified man page did not know what he was talking
about, or was not being precise.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
