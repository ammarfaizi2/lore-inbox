Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277735AbSKED5a>; Mon, 4 Nov 2002 22:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277741AbSKED5a>; Mon, 4 Nov 2002 22:57:30 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:20103 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S277735AbSKED51>; Mon, 4 Nov 2002 22:57:27 -0500
Message-Id: <200211050401.gA541YPi006905@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 4 Nov 2002 23:01:30 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: george anzinger <george@mvista.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
References: <3DC71BBF.5BBDCECF@mvista.com> <Pine.LNX.4.44.0211042035330.20254-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211042035330.20254-100000@chaos.physics.uiowa.edu>; from kai@tp1.ruhr-uni-bochum.de on Mon, Nov 04, 2002 at 08:37:31PM -0600
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop018.verizon.net from [141.150.241.241] at Mon, 4 Nov 2002 22:03:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Mon, 4 Nov 2002, george anzinger wrote:
> 
> > I think we need a newer objcopy :(
> 
> Alternatively, use this patch. (It's not really needed to force people to 
> upgrade binutils when ld can do the job, as it e.g. does in 
> arch/i386/boot/compressed/Makefile already).
>
> -	( cd $(obj) ; ./gen_init_cpio | gzip -9c > initramfs_data.cpio.gz )
> +	( cd $(obj) ; ./$< | gzip -9c > $@ )

I get errors with your patch.  I had to remove the 'cd $(obj)' above
from usr/Makefile.

-- 
Skip
