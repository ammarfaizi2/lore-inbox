Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135810AbRDZSDy>; Thu, 26 Apr 2001 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbRDZSDo>; Thu, 26 Apr 2001 14:03:44 -0400
Received: from idiom.com ([216.240.32.1]:25605 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S135810AbRDZSDd>;
	Thu, 26 Apr 2001 14:03:33 -0400
Message-ID: <3AE87D74.5D75BB8@namesys.com>
Date: Thu, 26 Apr 2001 12:56:36 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] [PATCH/URL] Endian Safe ReiserFS
In-Reply-To: <3AE85F24.1010208@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

>    I've just completed my port of ReiserFS to be endian safe. The patch
> has been tested successfully on x86 (UP/SMP), ppc (UP/SMP), and
> UltraSparc (UP). I've received reports that it also works successfully
> on mips (UP).
>
>    The patch preserves the little-endian disk format, so a disk can be
> moved across architectures. The on-disk format has not been altered, so
> the code can be patched in without disruption to users with existing
> reiserfs filesystems (like myself :)). There are no VFS changes.
>
>    Due to the patches affecting all of ReiserFS, the patch is quite
> large (180K), and so in the interests of preserving bandwidth for
> everyone, I've decided to post a URL to the patch instead.
>
>    The patch can be found at:
> http://penguinppc.org/~jeffm/releases/endian-safe-reiserfs-for-2.4.4-pre7.final.bz2
>
>    More information, including the endian safe utiltities, can be found
> at http://penguinppc.org/~jeffm.
>
>    -Jeff

You might consider sending the patch to the maintainer of ReiserFS.

Hans

