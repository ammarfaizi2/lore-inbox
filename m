Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbQKHVD6>; Wed, 8 Nov 2000 16:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbQKHVDs>; Wed, 8 Nov 2000 16:03:48 -0500
Received: from inet-smtp4.oracle.com ([209.246.15.58]:39616 "EHLO
	inet-smtp4.us.oracle.com") by vger.kernel.org with ESMTP
	id <S129825AbQKHVDg>; Wed, 8 Nov 2000 16:03:36 -0500
Message-ID: <3A09BF8F.6AC771D3@oracle.com>
Date: Wed, 08 Nov 2000 16:03:11 -0500
From: "Carey M. Drake" <carey.drake@oracle.com>
Organization: Oracle Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@suse.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Network error
In-Reply-To: <Pine.LNX.4.21.0011081258310.259-100000@euclid.oak.suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guess: you're using RedHat 7.0 (or somehow else are using a "new"
version of gcc).
Either use make cc=kgcc for redhat or downgrade gcc to a supported
version.

James Simmons wrote:
> 
> Something I seen on a lug. Anyone have a patch for this?
> 
> I'm trying to compile a 2.2.17 kernel.  When I do a make bzImage, I get
> this error.  It seems to be centering on networking areas (nfs, svclock,
> tcp, etc.)
> 
> tcp_input.c:1393:52: warning: pasting would not give a valid preprocessing
> token
> tcp_input.c:1441:85: warning: pasting would not give a valid preprocessing
> token
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
C.

------------------------------------------------------------------------------  

When in doubt, poke it with a stick

Disclaimer: the above is the author's personal opinion and is not the
opinion
or policy of his employer or of the little green men that have been
following
him all day.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
