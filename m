Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVIKPnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVIKPnX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 11:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVIKPnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 11:43:23 -0400
Received: from smtpout.mac.com ([17.250.248.70]:52931 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964809AbVIKPnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 11:43:22 -0400
In-Reply-To: <20050911114435.5990.qmail@science.horizon.com>
References: <20050911114435.5990.qmail@science.horizon.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <808CC4DC-15F3-4F6E-A9C6-6CBEC3D5415F@mac.com>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Date: Sun, 11 Sep 2005 11:43:02 -0400
To: linux@horizon.com
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 11, 2005, at 07:44:35, linux@horizon.com wrote:
>> I'll bite - what distros are shipping a kernel 2.6.10 or later and  
>> still
>> using devfs?
>
> Debian.  The current Debian installer is unfortunately rather tightly
> coupled to devfs; the reasons for choosing it are rooted in boot  
> floppy
> size, but the development ("unstable") install image uses 2.6.12 +  
> devfs.
>
> I just had to do a little dance to install it on a machine where
> 2.6.12 didn't recognize the SATA controller but 2.6.13 counldn't
> run the installer.
>
> Note that Debian doesn't need devfs in normal operation; it's just
> a bootstrapping tool.

That sounds like _exactly_ the case where the Debian folks could  
maintain
the out-of-tree ndevfs patch for a while until they got their installer
floppies and such migrated to udev.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


