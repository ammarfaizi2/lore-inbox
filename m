Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUGOKSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUGOKSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 06:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUGOKSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 06:18:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1175 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264061AbUGOKSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 06:18:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Dave Woods" <dwoods@fastclick.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Problems with DMA on IDE/ServerWorks/Seagate.
Date: Thu, 15 Jul 2004 12:24:45 +0200
User-Agent: KMail/1.5.3
Cc: "Stephanie Marasciullo" <smarasciullo@fastclick.com>
References: <7632915A8F000C4FAEFCF272A880344105095A@Ehost067.exch005intermedia.net>
In-Reply-To: <7632915A8F000C4FAEFCF272A880344105095A@Ehost067.exch005intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407151224.45341.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 of July 2004 02:16, Dave Woods wrote:
> Please CC me on all replies, as I am not subscribed to the list.
>
> We have diagnosed a problem (file corruption) using Ultra DMA & IDE with
>
> ServerWorks OSB4 Chipset and Seagate drives under heavy disk I/O.
> We were able to find a thread that discusses this problem in detail,
> but dates back to 2001. We have nearly 100 boxes using this
> configuration
> with kernal 2.4.20, and we can reproduce the problem easily with a perl
> script using md5 checksums.
>
> The applicable thread is given below:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.3/1006.html
>
> We've disabled DMA on several machines, and that appears to fix
> the problem. However, despite seeing this workaround mentioned
> several times, we have not had any luck downshifting to mdma2.
> Every time I attempt it, all disk accesses freeze up, and the box
> has to be rebooted.
>
> Our question: short of disabling DMA on all of our machines, what
> other alternatives are there? I've played with using the hdparm -p
> parameter prior to issuing hdparm -X34 and hdparm -d1, but it
> doesn't like it. Is there a simple fix to this problem out there?

Upgrade to 2.4.26 and see if it fixes your problem.

