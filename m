Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbTCGVMd>; Fri, 7 Mar 2003 16:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbTCGVMd>; Fri, 7 Mar 2003 16:12:33 -0500
Received: from c66-235-4-135.sea2.cablespeed.com ([66.235.4.135]:65331 "EHLO
	darklands.zimres.net") by vger.kernel.org with ESMTP
	id <S261783AbTCGVMb>; Fri, 7 Mar 2003 16:12:31 -0500
Date: Fri, 7 Mar 2003 13:14:05 -0800
From: Thomas Zimmerman <Thomas@zimres.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK FBDEV] Updates.
Message-Id: <20030307131405.59df9f38.Thomas@zimres.net>
In-Reply-To: <Pine.LNX.4.44.0303061528000.4540-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303061528000.4540-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003 08:40:14 -0800 (PST)
James Simmons <jsimmons@infradead.org> wrote:

> 
> Linus, please do a
> 
> 	bk pull http://fbdevA.bkbits.net/fbdev-2.5
> 
> This will update the following files:
[snip]
>  drivers/video/sis/325vtbl.h                | 2335 -----
>  drivers/video/sis/sisfb.h                  |  153
>  drivers/video/sstfb.h                      |  355
[snip]
>  include/linux/sisfb.h                      |  169
[snip]
>  drivers/video/sis/300vtbl.h                | 1373 ++-
>  drivers/video/sis/310vtbl.h                | 2465 ++++-
>  drivers/video/sis/init.c                   | 5841 ++++++++-----
>  drivers/video/sis/init.h                   |  303
>  drivers/video/sis/init301.c                |12286
>  ++++++++++++++++++----------- drivers/video/sis/init301.h            
>     |  508 -
>  drivers/video/sis/initdef.h                |  114
>  drivers/video/sis/oem300.h                 |  468 +
>  drivers/video/sis/oem310.h                 |  218
>  drivers/video/sis/osdef.h                  |   13
>  drivers/video/sis/sis.h                    |   10
>  drivers/video/sis/sis_accel.c              |  166
>  drivers/video/sis/sis_accel.h              |  509 +
>  drivers/video/sis/sis_main.c               | 4526 ++++++----
>  drivers/video/sis/sis_main.h               |  672 +
>  drivers/video/sis/vgatypes.h               |   26
>  drivers/video/sis/vstruct.h                |  683 +
[snip]
>  include/video/sisfb.h                      |  191
[snip]
> <jsimmons@maxwell.earthlink.net> (03/03/05 1.939)
>    [FBDEV] Updates for the SIS fbdev driver to the new api. Removed
>    poll. We wil use signals in the future instead.
[snip]
> Diff is at http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


Happily using this as sis fb doesn't compile in 2.5.64; This is the
first 2.5 kernel that boots for me. X seems faster than under 2.4. This
(almost) all sis based laptop likes things now.

Thomas
