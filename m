Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269081AbUIXTnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269081AbUIXTnC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269048AbUIXTnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:43:02 -0400
Received: from mx01.netapp.com ([198.95.226.53]:22013 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S269072AbUIXTmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:42:49 -0400
Message-ID: <415478B4.7090208@netapp.com>
Date: Fri, 24 Sep 2004 15:42:44 -0400
From: David Wysochanski <davidw@netapp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: reiserfs and SCSI oops seen in 2.6.9-rc2 with local SCSI disk
 IO
References: <4154372C.7070506@netapp.com> <20040924193942.GA17460@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20040924193942.GA17460@ip68-4-98-123.oc.oc.cox.net>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> On Fri, Sep 24, 2004 at 11:03:08AM -0400, David Wysochanski wrote:
>  > I can reproduce this pretty easily with local disk.
> [snip]
> 
> Make absolutely very very sure that you are *NOT* using SELinux --
> reiserfs and SELinux do NOT get along right now (this is a known
> problem). If you try to use the two together, you'll almost certainly
> get freezes and oopses.
> 
Nope - here's my /proc/cmdline:
root=0802 vga=0x314 selinux=0 splash=silent desktop resume=/dev/sda1 showopts console=tty0 console=ttyS0,9600n8 nmi_watchdog=1


> If you're seeing this type of problem even without SELinux, that's
> interesting...
> 
> -Barry K. Nathan <barryn@pobox.com>
> 


