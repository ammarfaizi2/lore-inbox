Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUIMLPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUIMLPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 07:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUIMLPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 07:15:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:27818 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265489AbUIMLP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 07:15:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm5
Date: Mon, 13 Sep 2004 13:16:36 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org> <200409131248.53098.rjw@sisk.pl>
In-Reply-To: <200409131248.53098.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409131316.36200.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:

On Monday 13 of September 2004 12:48, Rafael J. Wysocki wrote:
> On Monday 13 of September 2004 10:50, Andrew Morton wrote:
> > 
> > Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
> > 
> >  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
> 
> I can't build it on x86-64:
> 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> fs/built-in.o(.text+0xd1893): In function `mask_ok_common':
> : undefined reference to `vfs_permission'
> make: *** [.tmp_vmlinux1] Error 1

It's reiser4, apparently:

  CC      fs/reiser4/plugin/security/perm.o
fs/reiser4/plugin/security/perm.c: In function `mask_ok_common':
fs/reiser4/plugin/security/perm.c:16: warning: implicit declaration of 
function `vfs_permission'

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
