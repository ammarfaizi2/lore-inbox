Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbULPI2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbULPI2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbULPI0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:26:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:63655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262645AbULPI0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:26:24 -0500
Date: Thu, 16 Dec 2004 00:25:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, ak@suse.de, rlrevell@joe-job.com, tiwai@suse.de,
       mst@mellanox.co.il, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules.
 ioctl32 revisited.
Message-Id: <20041216002539.60d37dfe.akpm@osdl.org>
In-Reply-To: <20041216080952.GL32718@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de>
	<20041215074635.GC11501@mellanox.co.il>
	<s5hbrcvqv7r.wl@alsa2.suse.de>
	<1103135460.18982.68.camel@krustophenia.net>
	<20041216050356.GH32718@wotan.suse.de>
	<20041216075301.GC11047@elte.hu>
	<20041216080952.GL32718@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> I think Michael's patch is best (but I'm probably biased) because it addresses
>  the independent problem of a race in unregister_ioctl32_conversion() too
>  (and some other smaller issues in ioctl 32bit emulation)

They should be separate patches.

>  Andrew, could we replace unlocked_ioctl.patch with Michael's patch?

Where would one locate Michael's patch?
