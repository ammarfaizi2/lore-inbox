Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265325AbUE0VsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUE0VsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265481AbUE0VsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:48:17 -0400
Received: from lug.demon.co.uk ([80.177.165.112]:2123 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S265325AbUE0VrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:47:07 -0400
From: David Johnson <dj@david-web.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Date: Thu, 27 May 2004 22:47:15 +0100
User-Agent: KMail/1.6
References: <200405271736.08288.dj@david-web.co.uk> <200405271925.24650.dj@david-web.co.uk> <1085692088.5311.63.camel@buffy>
In-Reply-To: <1085692088.5311.63.camel@buffy>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jHmtAItqtDfYQ1u"
Message-Id: <200405272247.15579.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jHmtAItqtDfYQ1u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 27 May 2004 22:08, David Aubin wrote:
> Hi Dave,
>
>   I think the problem is this:
>  hd0,0 is /dev/hda1.  Your kernel is in /dev/hda3.
> You want to have hd0,2, not hd0,0.  As for the output
> you see.  You must have a kernel at /dev/hda1 that does
> not support XFS and hence the unknown fs error.
> Please fix your grub entry and you should have fun.
>

Nope. My kernel is on /dev/hda1 (hd0,0) which is the boot partition. 
Then /dev/hda3 is the root partition.

I am booting the correct kernel - with XFS support.

> Cna you send dmesg output for 2.4 and 2.6 if you can caputer the latter.
> If not please compare them manually and check whether hda is still the
> same device as in 2.4.  Also check if 2.6 finds more or less partitions.

I've attached my 2.4 dmesg.
I can't capture or even read the 2.6 output as it scrolls off the screen too 
fast. I think it's finding the drive and using the correct IDE chipset 
driver, but I can't see the details.

I really can't see why this is happening. All the usual IDE stuff is compiled 
in, as is the correct IDE chipset driver, as is XFS...

Thanks,
David.

-- 
David Johnson
http://www.david-web.co.uk/

--Boundary-00=_jHmtAItqtDfYQ1u
Content-Type: application/x-gzip;
  name="dmesg-2.4.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="dmesg-2.4.gz"

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
/CbO4wN2de2f8U/xjNslAAA=

--Boundary-00=_jHmtAItqtDfYQ1u--
