Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288974AbSAFQEF>; Sun, 6 Jan 2002 11:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288975AbSAFQD4>; Sun, 6 Jan 2002 11:03:56 -0500
Received: from tourian.nerim.net ([62.4.16.79]:41991 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S288974AbSAFQDg>;
	Sun, 6 Jan 2002 11:03:36 -0500
Message-ID: <3C387556.2040108@free.fr>
Date: Sun, 06 Jan 2002 17:03:34 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020105
X-Accept-Language: en-us
MIME-Version: 1.0
To: christian e <cej@ti.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
In-Reply-To: <3C386DC9.307@ti.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christian e wrote:

> Hi,all
> 


Simply try to disable swap (swapoff -a or comment out swap partitions in 
/etc/fstab and reboot).
I did this on a 384 MiB SMP box as I had bad interactive performance 
with some desktop apps and heavy background disk I/O (video grabing) 
around 2.4.10-2.4.13 (I did not reactivate swap since) and it solved my 
interactive perf woes.

You might also try Andrea's patches:
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa2.bz2

or/and Rik's ones:
http://www.surriel.com/patches/2.4/2.4.17-rmap-10c

LB.

