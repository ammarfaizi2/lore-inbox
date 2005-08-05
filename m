Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVHEEXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVHEEXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 00:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVHEEXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 00:23:03 -0400
Received: from relay00.pair.com ([209.68.1.20]:14858 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262856AbVHEEXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 00:23:02 -0400
X-pair-Authenticated: 24.126.76.52
Message-ID: <42F2E721.9020707@kegel.com>
Date: Thu, 04 Aug 2005 21:12:17 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Van Tuyl <gvtlinux@xmission.com>
Subject: re: make modules Segfault
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Van Tuyl <gvtlinux@xmission.com> wrote:
 > gcc: Internal error: Segmentation fault (program cpp0)
 > ...
 > make[3]: Leaving directory `/usr/src/linux-2.4.31/drivers/net/wan'
 > ...
 > Gnu C                  2.96
 > ...
> cpu family    : 6
> model         : 4
> model name    : AMD Athlon(tm) Processor
> stepping      : 4
> cpu MHz       : 1400.110
> ...
 > I  expect you to tell me to upgrade everything.

Nah.  Stop overclocking, and *then* upgrade everything :-)

Seriously, it seems like your machine is flaky.
And even if it were a kernel source problem,
gcc should never have an internal error.
But gcc-2.96 is so old that it's not supported anymore.
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
