Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFNWG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTFNWG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:06:28 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:31393 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261180AbTFNWG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:06:26 -0400
Message-ID: <3EEB9FF1.7090104@sixbit.org>
Date: Sat, 14 Jun 2003 18:21:37 -0400
From: John Weber <weber@sixbit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.5.71
References: <20030614213012$6a47@gated-at.bofh.it>
In-Reply-To: <20030614213012$6a47@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather trivial patch, but it looks like it's needed.

--- flow.old    2003-06-14 18:17:35.000000000 -0400
+++ flow.c      2003-06-14 18:13:03.000000000 -0400
@@ -5,6 +5,7 @@
   */

  #include <linux/kernel.h>
+#include <linux/cpu.h>
  #include <linux/list.h>
  #include <linux/jhash.h>
  #include <linux/interrupt.h>

Linus Torvalds wrote:
> There's nothing hugely interesting here, but Al Viro ha sbeen cleaning up 
> the tty layer, and Stephen Hemminger has been fixing up some network 
> device alloc/free issues with the help of various people.

