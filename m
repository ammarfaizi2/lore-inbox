Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbULITzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbULITzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbULITzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:55:40 -0500
Received: from [206.71.178.18] ([206.71.178.18]:35509 "EHLO storix.com")
	by vger.kernel.org with ESMTP id S261592AbULITzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:55:33 -0500
Subject: Re: initrd and fc3
From: rich turner <rich@storix.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <41B8AAF9.6000807@gmail.com>
References: <1102620480.19320.8.camel@rich>  <41B8AAF9.6000807@gmail.com>
Content-Type: text/plain
Message-Id: <1102622346.19320.12.camel@rich>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Dec 2004 11:59:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 11:43, Matan Peled wrote:
> rich turner wrote:
> 
> >i am testing fc3 by using an old-school initrd. by old-school i mean not
> >the new initramfs/cpio type initrd. the process i use to create the
> >initrd works for all other distributions (suse, mandrake, debian, fc2,
> >2.2.x, 2.4.x, 2.6.x, etc) but fails with fc3 (2.6.9-1.667).
> >
> >upon system boot, the kernel executes, checks to see if the initrd is
> >initramfs (it isnt), finds the initrd (ext2), mounts it, and then
> >immediately exits without executing linuxrc.
> >
> >anyone have any ideas as to why linuxrc is not being executed?
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >  
> >
> You pretty much deduced the bug is in FC3, and not the general kernel...
> 
> So why exactly is this on topic on LKML?
i agree that this isnt the proper place for this topic if it is only
related to fc3.
> 
> 
> Is the bug reproducible on a vanilla kernel.org kernel?
i am doing this now. if this is reproducable in vanilla 2.6.9 then i
will let the list know.
> 
> - Mif
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

