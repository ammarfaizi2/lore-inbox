Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132670AbRCMV51>; Tue, 13 Mar 2001 16:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRCMVcA>; Tue, 13 Mar 2001 16:32:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7373 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131191AbRCMVax>;
	Tue, 13 Mar 2001 16:30:53 -0500
Message-ID: <3AAD55AC.DFD0A41E@eyal.emu.id.au>
Date: Tue, 13 Mar 2001 10:03:08 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac19
In-Reply-To: <E14cYWp-0002Xu-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
>         ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
>                 Intermediate diffs are available from
> 
>                         http://www.bzimage.org
> 
> (Note that the cmsfs port to 2.4 is a work in progress)
> 
> 2.4.2-ac19


It does not build anymore. It seems that someone thinks Debian has db3
(it does not, at least not the stable release which is all that
matters).

I already had two links:
	/usr/lib/libdb.so -> /usr/lib/libdb2.so
	/usr/include/db   -> /usr/include/db2
that made it work for the last few patches - why break it now?

Of course, the best thing is to remove the whole db3 dependancy from
the kernel build and leave it in a special driver developer rule.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
