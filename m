Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUCDDaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUCDDaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:30:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:63135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261429AbUCDDaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:30:18 -0500
Date: Wed, 3 Mar 2004 19:30:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM patches in 2.6.4-rc1-mm2
Message-Id: <20040303193025.68a16dc4.akpm@osdl.org>
In-Reply-To: <40469E50.6090401@matchmail.com>
References: <20040302201536.52c4e467.akpm@osdl.org>
	<40469E50.6090401@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/
> > 
> > - More VM tweaks and tuneups
> 
> Running 2.6.3-lofft-snsus-264rc1mm2vm (nfsd loff_t, sunrpc locking & -mm 
> VM patches).  Seems to be working well.

OK, good.

> Most of the previous 2.6 kernels I was running on these servers would be 
> lightly hitting swap by now.  This definitely looks better to me.

It sounds worse to me.  "Lightly hitting swap" is good.  It gets rid of stuff,
freeing up physical memory.

But I do not see a lot of difference here.  The 900MB desktop machine is
300M into swap after 24 hours.  That's usual.

