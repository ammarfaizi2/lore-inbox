Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRCTD4R>; Mon, 19 Mar 2001 22:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129719AbRCTD4H>; Mon, 19 Mar 2001 22:56:07 -0500
Received: from chromium11.wia.com ([207.66.214.139]:56333 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S129624AbRCTDz4>; Mon, 19 Mar 2001 22:55:56 -0500
Message-ID: <3AB6D574.8C123AE9@chromium.com>
Date: Mon, 19 Mar 2001 19:58:44 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: user space web server accelerator support
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com> <15030.54194.780246.320476@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can Apache "grab" the file descriptor?

My understanding is that file descriptors are data structures private to
a process...

Am I missing something?

 - Fabio

"David S. Miller" wrote:

> Fabio Riccardi writes:
>  > How could this be fixed?
>
> Why not pass the filedescriptors to apache over a UNIX domain
> socket?  I see no need for a new facility.
>
> Later,
> David S. Miller
> davem@redhat.com

