Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWGGOFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWGGOFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGGOFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:05:10 -0400
Received: from mail.gmx.net ([213.165.64.21]:24496 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750937AbWGGOFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:05:08 -0400
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 07 Jul 2006 16:05:06 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060707131247.GX4188@suse.de>
Message-ID: <20060707140506.109310@gmx.net>
MIME-Version: 1.0
References: <20060707070703.165520@gmx.net>
 <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net>
 <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de>
 <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de>
 <20060707131247.GX4188@suse.de>
Subject: Re: splice/tee bugs?
To: Jens Axboe <axboe@suse.de>, michael.kerrisk@gmx.net
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, thep atch does not compile...

CC      fs/splice.o
fs/splice.c: In function 'link_pipe':
fs/splice.c:1448: error: expected 'while' before 'mutex_unlock'
make[1]: *** [fs/splice.o] Error 1
make: *** [fs] Error 2

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
