Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUAAWBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbUAAWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:01:25 -0500
Received: from pD9526784.dip.t-dialin.net ([217.82.103.132]:33152 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S265434AbUAAWBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:01:06 -0500
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 compile error
References: <18PmG-40b-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 01 Jan 2004 23:01:04 +0100
In-Reply-To: <18PmG-40b-9@gated-at.bofh.it> (Srihari Vijayaraghavan's
 message of "Wed, 31 Dec 2003 15:20:10 +0100")
Message-ID: <m3znd7ib1b.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari Vijayaraghavan <harisri@bigpond.com> writes:

> While "make bzImage", it showed these error messages:
>   CC      arch/x86_64/kernel/io_apic.o

I already submitted a patch to fix that and Linus merged it.
Use current -bk*

The MSI code is unfortunately quite broken and will need more
work to really work on anything except IA32.

-Andi
