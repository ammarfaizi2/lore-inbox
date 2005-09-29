Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVI2Tik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVI2Tik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVI2Tik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:38:40 -0400
Received: from mail1.kontent.de ([81.88.34.36]:60296 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S964797AbVI2Tii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:38:38 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 21:38:25 +0200
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
References: <433BC9E9.6050907@pobox.com> <200509292108.11092.oliver@neukum.org> <1128022473.14595.6.camel@cashmere.sps.mot.com>
In-Reply-To: <1128022473.14595.6.camel@cashmere.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509292138.26183.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 29. September 2005 21:34 schrieb Jon Loeliger:
> On Thu, 2005-09-29 at 14:08, Oliver Neukum wrote:
> 
> > Unfortunately, following the instructions to the letter produces this:
> > oliver@oenone:~/linux-2.6> git checkout
> > usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
> 
> Yeah.  See if you still have a .git/HEADS that symlinks
> to a valid place or not...?

oliver@oenone:~/linux-2.6> ls -la .git/
insgesamt 14
drwxrwxr-x    6 oliver users  224 2005-09-29 21:06 .
drwxr-xr-x    3 oliver users   72 2005-09-29 20:45 ..
-rw-rw-r--    1 oliver users   19 2005-05-02 01:02 description
lrwxrwxrwx    1 oliver users   17 2005-09-29 21:06 HEAD -> refs/heads/master
-rw-------    1 oliver users   32 2005-09-29 21:06 index
drwxrwxr-x    2 oliver users  104 2005-09-11 21:41 info
drwxr-xr-x  260 oliver users 6240 2005-09-29 19:05 objects
drwxrwxr-x    4 oliver users   96 2005-05-02 02:15 refs
drwxr-xr-x    2 oliver users   72 2005-09-29 21:05 remotes
oliver@oenone:~/linux-2.6> ls -la .git/refs/
insgesamt 1
drwxrwxr-x  4 oliver users  96 2005-05-02 02:15 .
drwxrwxr-x  6 oliver users 224 2005-09-29 21:06 ..
drwxrwxr-x  2 oliver users  72 2005-09-29 19:05 heads
drwxrwxr-x  2 oliver users 600 2005-09-20 05:02 tags
oliver@oenone:~/linux-2.6> ls -la .git/refs/heads/
insgesamt 4
drwxrwxr-x  2 oliver users 72 2005-09-29 19:05 .
drwxrwxr-x  4 oliver users 96 2005-05-02 02:15 ..
-rw-rw-r--  1 oliver users 41 2005-09-29 19:05 master
oliver@oenone:~/linux-2.6> cat .git/refs/heads/master
aa55a08687059aa169d10a313c41f238c2070488

	Regards
		Oliver
