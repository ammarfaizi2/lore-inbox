Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUJHAVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUJHAVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269869AbUJGW5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:57:38 -0400
Received: from smtp07.auna.com ([62.81.186.17]:30379 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S268182AbUJGWmr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:42:47 -0400
Date: Thu, 07 Oct 2004 22:42:43 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097178019.24355.39.camel@localhost>
In-Reply-To: <1097178019.24355.39.camel@localhost> (from haveblue@us.ibm.com
	on Thu Oct  7 21:40:19 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097188963l.6408l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.07, Dave Hansen wrote:
> I just booted 2.6.9-rc3-mm3 and got the good ol' 
> 
> VFS: Cannot open root device "sda2" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> 
> backing out bk-scsi.patch seems to fix it.  I believe this worked in
> 2.6.9-rc3-mm2.
> 

Mine works:

03:0c.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)

werewolf:~> uname -a
Linux werewolf.able.es 2.6.9-rc3-mm3 #1 SMP...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


