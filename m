Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTICBhl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTICBhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:37:41 -0400
Received: from codepoet.org ([166.70.99.138]:16099 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S261832AbTICBhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:37:40 -0400
Date: Tue, 2 Sep 2003 19:37:41 -0600
From: Erik Andersen <andersen@codepoet.org>
To: steveb@unix.lancs.ac.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: corruption with A7A266+200GB disk?
Message-ID: <20030903013741.GA1601@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	steveb@unix.lancs.ac.uk, linux-kernel@vger.kernel.org
References: <E19uBCi-00054b-00@wing0.lancs.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19uBCi-00054b-00@wing0.lancs.ac.uk>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 02, 2003 at 02:28:16PM +0100, steveb@unix.lancs.ac.uk wrote:
> 
> I just got a new 200GB disk (WDC WD2000JB) for my home machine (Asus A7A266,
> Ali chipset). I put some partitions on it like so:
>   hda1:   100MB - /boot
>   hda2:  8192MB - /
>   hda3:  1024MB - swap
>   hda4:  the rest (about 190GB I guess) - /home
> 
> I find that when I mkfs on /home, I get massive filesystem corruption on /
> When I fsck / (and restore the deleted files) I get massive filesystem corruption on /home. Luckily all my real data is still on my old disk...
> 
> I reduced the size of /home to 40GB and everything was fine.
> I see the same behaviour with both 2.6.0test3 and 2.4.22.

Known problem.  For some reason Marcelo has not yet applied 
the fix for this problem to the 2.4.x kernels...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
