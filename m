Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVFPPJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVFPPJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVFPPJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:09:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23530 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261684AbVFPPJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:09:29 -0400
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
From: Lee Revell <rlrevell@joe-job.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Michael Heyse <mhk@designassembly.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0506160523190.6459@p34>
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
	 <42B14415.5060105@designassembly.de> <Pine.LNX.4.63.0506160523190.6459@p34>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 10:59:14 -0400
Message-Id: <1118933954.2644.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-16 at 05:24 -0400, Justin Piszcz wrote:
> Alan followed up with me but we did not reach any conclusion as to what 
> was causing it to crash.  The main way I got it to crash was dd 
> if=/dev/hde (root drive) of=/nfs/file.img bs=1M, I have not had any issues 
> as far as copying files and such.  For you, is it on a particular box or 
> boxes, have you tried copying the other direction?  I use NFS over UDP btw 
> (v3).
> 
> # mount
> mount:/disk/1 on /remote/1 type nfs 
> (rw,hard,intr,nfsvers=3,addr=192.168.168.253)

Are you both using NFS + software RAID?  Is 4KSTACKS enabled?

IIRC people were getting stack overflows with the NFS + RAID + 4K stacks
combination.

Lee

