Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbULPQnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbULPQnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbULPQnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:43:55 -0500
Received: from pop-a065d05.pas.sa.earthlink.net ([207.217.121.249]:4244 "EHLO
	pop-a065d05.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261712AbULPQnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:43:35 -0500
Message-ID: <13677005.1103215413764.JavaMail.root@louie.psp.pas.earthlink.net>
Date: Thu, 16 Dec 2004 08:43:33 -0800 (PST)
From: bchimiak@earthlink.net
Reply-To: bchimiak@earthlink.net
To: linux-kernel@vger.kernel.org
Subject: More detail: Re: visor.ko freezes on dlpsh list
Cc: greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Earthlink Zoo Mail 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is the visor.[ch] of vmlinuz-2.6.9-1.681_FC3 that does not work.
I recompiled a linux-2.6.9 kernel and the pilot-xfer, dlpsh, and kpilot work
now.  It is the visor.[ch] in vmlinuz-2.6.9-1.681_FC3 that is the culprit.

-----Forwarded Message-----
From: bchimiak@earthlink.net
Sent: Dec 15, 2004 5:47 AM
To: Greg KH <greg@kroah.com>
Subject: Re: visor.ko freezes on dlpsh list

You asked: What kernel version are you using?
vmlinuz-2.6.9-1.681_FC3,
but the original Fedora Core 3 did not work either.
It was suggested to remove the visor diffs from the ac10 patch and that would work.
I may try building linux-2.6.9 and see how that works.

Bill Chimiak

-----Original Message-----
From: Greg KH <greg@kroah.com>
Sent: Dec 13, 2004 11:14 PM
To: Bill Chimiak <bchimiak@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: visor.ko freezes on dlpsh list

On Mon, Dec 13, 2004 at 09:19:52PM -0500, Bill Chimiak wrote:
> Summary: Handspring visor does not  fully sync with kpilot or jpilot
> or with pilot-xfer.
> With dlpsh, the user, and df work but it freezes with a ls command
> after completing about 75% to 80% of the actually listing.
What kernel version are you using?
thanks,
greg k-h
