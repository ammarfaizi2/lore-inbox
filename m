Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUEWSbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUEWSbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 14:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUEWSbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 14:31:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9949 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263295AbUEWSa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 14:30:59 -0400
Message-ID: <40B0EDD4.9090700@pobox.com>
Date: Sun, 23 May 2004 14:30:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix userspace inclusion of linux/fs.h (resend)
References: <yw1x1xlb6m1x.fsf@kth.se>
In-Reply-To: <yw1x1xlb6m1x.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> The patch below fixes compilation of userspace using linux/fs.h.  The
> patch is against Linux 2.6.6.  Please apply of fix some other way.


Userspace should not be directly including the kernel headers.

Some dude maintains a "linux-libc-headers" package, you probably want that.

	Jeff


