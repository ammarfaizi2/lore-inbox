Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVCYUYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVCYUYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVCYUYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:24:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:22669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261771AbVCYUYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:24:46 -0500
Date: Fri, 25 Mar 2005 12:24:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
Message-Id: <20050325122433.12469909.akpm@osdl.org>
In-Reply-To: <424471CB.3060006@mesatop.com>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<42446B86.7080403@mesatop.com>
	<424471CB.3060006@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> > 
>  > [   49.198779] EXT3-fs: mounted filesystem with ordered data mode.
>  > [   56.310394] PCI: Found IRQ 5 for device 0000:01:0c.0
>  > [  222.804956] rock: directory entry would overflow storage
>  > [  222.804978] rock: sig=0x5245, size=8, remaining=0
>  > [  235.551953] rock: directory entry would overflow storage
>  > [  235.551969] rock: sig=0x5850, size=36, remaining=34
>  > [  235.551976] rock: directory entry would overflow storage
>  > [  235.551981] rock: sig=0x5850, size=36, remaining=34
>  > 
>  > Sorry, I don't have the time to do further troubleshooting, but I
>  > hope this is enough information.  The .config for this machine was
>  > posted earlier in another thread here:
>  > http://marc.theaimsgroup.com/?l=linux-kernel&m=111167720523853&w=2
>  > 
>  > Steven
> 
>  I found a few more minutes to test two more kernels.  The problem
>  first occured with 2.6.12-rc1-mm2:
> 
>  2.6.12-rc1     reads the cd-rom OK as reported earlier
>  2.6.12-rc1-mm1 also reads the cd-rom OK
>  2.6.12-rc1-mm2 broken same as -mm3 described as above
>  2.6.12-rc1-mm3 broken as reported earlier

Are you really really sure about that?  -mm3 included both the bk-ide-dev
tree and the isofs changes.  2.6.12-rc1-mm2 had neither.

