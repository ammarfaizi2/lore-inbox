Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265889AbUGHHQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbUGHHQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbUGHHMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:12:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:24285 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265883AbUGHHLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 03:11:35 -0400
Date: Thu, 8 Jul 2004 00:10:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Autoregulate swappiness & inactivation
Message-Id: <20040708001027.7fed0bc4.akpm@osdl.org>
In-Reply-To: <cone.1089268800.781084.4554.502@pc.kolivas.org>
References: <40EC13C5.2000101@kolivas.org>
	<40EC1930.7010805@comcast.net>
	<40EC1B0A.8090802@kolivas.org>
	<20040707213822.2682790b.akpm@osdl.org>
	<cone.1089268800.781084.4554.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
>  Ah what the heck. They can only be knocked back to where they already are.

hm.  You get an eGrump for sending two patchs in one email.  Surprisingly
nice numbers though.

How come vm_swappiness gets squared?  That's the mysterious "bias
downwards", yes?  What's the theory there?

Please define this new term "application pages"?

Those si_swapinfo() and si_meminfo() calls need to come out of there.

A diff against Documentation/filesystems/proc.txt will be needed sometime,
please.
