Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSFJOHd>; Mon, 10 Jun 2002 10:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSFJOGh>; Mon, 10 Jun 2002 10:06:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20573 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315415AbSFJOFg>; Mon, 10 Jun 2002 10:05:36 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: thunder@ngforever.de (Thunder from the hill), davej@suse.de (Dave Jones),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206092104.g59L4JD448386@saturn.cs.uml.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Jun 2002 07:55:57 -0600
Message-ID: <m1vg8rutjm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Thunder from the h writes:
> > On 9 Jun 2002, Eric W. Biederman wrote:
> 
> >> #include <linux/*>
> >> and 
> >> #include <asm/*>
> >> are no longer supported.
> 
> Try "are no longer supplied by raw kernel source" instead.
> They damn well better exist, cleaned up for non-kernel use.

And user space should gradually be fixed from using them.  In almost
every case there are more appropriate headers to use.  Basically
keeping the /usr/include/linux and /usr/include/asm  directories is a
crutch to allow a slow user space transition.

Actually by now most applications have been fixed and do not use
them.  The policy has been in place for several years now.

Eric
