Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbTF3J5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbTF3J5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:57:30 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:19219 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265824AbTF3J5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:57:20 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@digeo.com>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Mon, 30 Jun 2003 12:10:06 +0200
User-Agent: KMail/1.5.2
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org, zwane@linuxpower.ca, efault@gmx.de
References: <200306281516.12975.kernel@kolivas.org> <200306301135.37960.m.c.p@wolk-project.de> <20030630024749.77be1d6d.akpm@digeo.com>
In-Reply-To: <20030630024749.77be1d6d.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306301207.27585.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 11:47, Andrew Morton wrote:

Hi Andrew,

> >  "make -j16 bzImage modules" of a 2.5.73-mm2 tree makes XMMS skip easily
> Well it would.   Try not to do that.  We shouldn't optimise
> for things which basically nobody would do.
> `make -j2' would be more interesting.
Well, it shouldn't *imho*. And it is possible. Currently I am running 
2.4.20-wolk4.3 and I do "make -j32 bzImage modules" and I cannot make XMMS 
skip doesn't matter what I do, it is not possible. Even X is smooth, kmail 
does not freeze, an Xterm needs ~4 seconds to open.

My tree uses the O(1) from Andrea including the fixes.

Now I've tried your suggestion, "make -j2" with .73-mm2 + the mentioned 
patches. Three skips during the whole compilation (bzImage modules).

ciao, Marc

