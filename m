Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUE0U4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUE0U4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUE0U4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:56:02 -0400
Received: from lug.demon.co.uk ([80.177.165.112]:50245 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S265237AbUE0Uzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:55:44 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Date: Thu, 27 May 2004 21:55:50 +0100
User-Agent: KMail/1.6
References: <200405271736.08288.dj@david-web.co.uk> <200405271925.24650.dj@david-web.co.uk> <1085684685.5311.59.camel@buffy>
In-Reply-To: <1085684685.5311.59.camel@buffy>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405272155.50992.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 May 2004 20:04, David Aubin wrote:
> Did you create these drives with any of the following
> attributes?
> # CONFIG_XFS_RT is not set
> # CONFIG_XFS_QUOTA is not set
> # CONFIG_XFS_SECURITY is not set
> # CONFIG_XFS_POSIX_ACL is not set
> If you did then please enable them and rebuild your kernel.

Nope, it's just a plain XFS partition as created by debian-installer.

>
> Also, hd(0,0) is /dev/hda3 correct?  You didn't swap
> ide cables or anything and are now tring to boot off of
> an old kernel?

hd(0,0) is hda1 which is the boot partition. And no I've not touched the IDE 
cables. A 2.4 kernel with an almost identical Grub entry works fine.

>
> I don't have an XFS system.  But I belive it works with 2.6.*
> kernels.  You problem looks like you are missing xfs support in
> your kernel.  If you say you have it compilied in, then perhaps
> you are not booting the kernel you think you are.

I have XFS working fine with 2.6.6 on another machine.
I've just made sure that I'm booting the correct kernel, and I am.

This is starting to drive me mad now!

Thanks,
David.

-- 
David Johnson
http://www.david-web.co.uk/
