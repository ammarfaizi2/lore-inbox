Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTJARPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTJARPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:15:21 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19426 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262467AbTJARPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:15:18 -0400
From: Vitaly Fertman <vitaly@namesys.com>
Organization: NAMESYS
To: Zan Lynx <zlynx@acm.org>
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
Date: Wed, 1 Oct 2003 21:15:16 +0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <1064936688.4222.14.camel@localhost.localdomain> <200309302006.32584.vitaly@namesys.com> <1065019441.4226.1.camel@localhost.localdomain>
In-Reply-To: <1065019441.4226.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310012115.16760.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel is 2.6.0-test6 from kernel.org.  No other patches.
>
> Okay, I did cat file > /dev/null on each one.  It looks like the problem
> is with oidmap.  The other files do not crash.

we found a bug in the kernel 2.6.0-test6 and working on the fix.

-- 
Thanks,
Vitaly Fertman
