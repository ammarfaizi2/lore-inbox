Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUEWTBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUEWTBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUEWTBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:01:14 -0400
Received: from mail.broadpark.no ([217.13.4.2]:4785 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263370AbUEWTBE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:01:04 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix userspace inclusion of linux/fs.h (resend)
References: <yw1x1xlb6m1x.fsf@kth.se> <40B0EDD4.9090700@pobox.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Sun, 23 May 2004 21:04:26 +0200
In-Reply-To: <40B0EDD4.9090700@pobox.com> (Jeff Garzik's message of "Sun, 23
 May 2004 14:30:44 -0400")
Message-ID: <yw1xwu3355j9.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Måns Rullgård wrote:
>> The patch below fixes compilation of userspace using linux/fs.h.  The
>> patch is against Linux 2.6.6.  Please apply of fix some other way.
>
> Userspace should not be directly including the kernel headers.
>
> Some dude maintains a "linux-libc-headers" package, you probably want that.

I still fail to see the point in maintaining three separate sets of
header files, but that has been discussed in the past.

-- 
Måns Rullgård
mru@kth.se
