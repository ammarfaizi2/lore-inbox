Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbTIVLuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbTIVLuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:50:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60669 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263112AbTIVLuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:50:06 -0400
Date: Mon, 22 Sep 2003 13:49:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Will Dyson <will_dyson@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm4: BeFS compile error
Message-ID: <20030922114958.GR6325@fs.tum.de>
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922013548.6e5a5dcf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 01:35:48AM -0700, Andrew Morton wrote:
>...
> befs-use-parser.patch
>   BEFS: Use table-driven option parsing
>...

It seems this patch broke the compilation of BeFS:

<--  snip  -->

...
  CC      fs/befs/linuxvfs.o
fs/befs/linuxvfs.c: In function `parse_options':
fs/befs/linuxvfs.c:712: too few arguments to function `match_int'
fs/befs/linuxvfs.c:724: too few arguments to function `match_int'
make[2]: *** [fs/befs/linuxvfs.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

