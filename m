Return-Path: <linux-kernel-owner+w=401wt.eu-S936902AbWLIL02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936902AbWLIL02 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936925AbWLIL02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:26:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:59669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936919AbWLIL01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:26:27 -0500
X-Authenticated: #1587495
From: Stefan Lippers-Hollmann <s.L-H@gmx.de>
To: stable@kernel.org
Subject: Re: [patch 00/32] -stable review
Date: Sat, 9 Dec 2006 12:26:19 +0100
User-Agent: KMail/1.9.5
References: <20061208235751.890503000@sous-sol.org>
In-Reply-To: <20061208235751.890503000@sous-sol.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612091226.22936.s.L-H@gmx.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Saturday 09 December 2006 00:57, you wrote:
> This is the start of the stable review cycle for the 2.6.19.1 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let us know.  If anyone is a maintainer of the proper subsystem, and
> wants to add a Signed-off-by: line to the patch, please respond with it.

At least
http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc1.gz
and
http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc2.gz
seem to contain an incompletely applied "[patch 24/32] add bottom_half.h",
bottom_half.h itself is missing, while interrupt.h and spinlock.h are changed 
to use the missing file:

$ wget -qO- http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc2.gz | gzip -dc | grep bottom_half
+#include <linux/bottom_half.h>
+#include <linux/bottom_half.h>
$ wget -qO- http://kernel.org/pub/linux/kernel/people/chrisw/stable/patch-2.6.19.1-rc1.gz | gzip -dc | grep bottom_half
+#include <linux/bottom_half.h>
+#include <linux/bottom_half.h>

> These patches are sent out with a number of different people on the
> Cc: line.  If you wish to be a reviewer, please email stable@kernel.org
> to add your name to the list.  If you want to be off the reviewer list,
> also email us.
>
> Responses should be made by Mon Dec 11 00:00 UTC Anything received after
> that time might be too late.
>
> thanks,
>
> the -stable release team

Thanks a lot for the -stable rc patches
	Stefan Lippers-Hollmann
