Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVA0AQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVA0AQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVA0AQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:16:25 -0500
Received: from lakermmtao06.cox.net ([68.230.240.33]:17293 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262479AbVAZWS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:18:56 -0500
In-Reply-To: <1106728499.3646.45.camel@localhost>
References: <1106685009.8968.15.camel@localhost> <1106728499.3646.45.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <43F70EA3-6FE8-11D9-A93E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Drive missing only with LVM kernel
Date: Wed, 26 Jan 2005 17:18:54 -0500
To: Jasper Koolhaas <jasper@Morgana.NET>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 26, 2005, at 03:34, Jasper Koolhaas wrote:
> Oh, and I'm using a devfs so "cd /dev && ./MAKEDEV hdg" is not the
> solution I think.
>
> The odd thing is that without LVM compiled in the kernel or as
> module /dev/hdg is accessible through devfs and with LVM not.

Well, devfs has been deprecated and mostly unmaintained since before
2.6.0 was released, so it really doesn't surprise me.  Go download
and install udev, hotplug, etc from your distro.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


