Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbUKWPy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbUKWPy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUKWPwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:52:49 -0500
Received: from iris.icglink.com ([216.183.105.244]:8158 "HELO iris.icglink.com")
	by vger.kernel.org with SMTP id S261309AbUKWPhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:37:47 -0500
Date: Tue, 23 Nov 2004 09:37:44 -0600
From: Phil Dier <phil@dier.us>
To: linux-kernel@vger.kernel.org
Cc: Scott Holdren <scott@icglink.com>, ziggy <ziggy@icglink.com>,
       Jack Massari <webmaster@icglink.com>
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041123093744.25c09245.phil@dier.us>
In-Reply-To: <20041122161725.21adb932.akpm@osdl.org>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004 16:17:25 -0800
Andrew Morton <akpm@osdl.org> wrote:

> yow. The dread combination of XFS, LVM, software RAID and bloaty scsi
> drivers. Looks like a stack overrun.
>
> Can you rebuild the kernel with CONFIG_4KSTACKS=n?
>

Thanks for the suggestion.. I'm doing a burn-in right now with 8k
stacks, and so far, so good.

I'm building this system with stability and flexibility foremost in
mind. Am I foolish in using all of these technologies with a new-ish
version of 2.6? Is there a particular version that would be better
suited for my application? Any other suggestions you (or anyone else
on the list) could give regarding stability would be greatly appreciated.

Thanks,

--

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
