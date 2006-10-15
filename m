Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWJOSmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWJOSmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWJOSmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:42:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20235 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030206AbWJOSmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:42:21 -0400
Date: Sun, 15 Oct 2006 20:42:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Petr Vandrovec <petr@vandrovec.name>
Subject: Re: Bad core files with 2.6.19-rc2
Message-ID: <20061015184217.GZ30596@stusta.de>
References: <microsoft-free.87mz7yjnm2.fsf@youngs.au.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <microsoft-free.87mz7yjnm2.fsf@youngs.au.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 12:53:41PM +1000, Steve Youngs wrote:

> gdb doesn't like any core dump file generated while running
> 2.6.19-rc2.  If I `kill -SIGSEGV $some_app_pid' and then...
> 
>   gdb some_app core
> 
> I get...
> 
>   warning: Couldn't find general-purpose registers in core file.
>   #0  0x00000000 in ?? ()
> 
> But if I gdb attach to a running process and then kill -SIGSEGV
> the process, it produces a normal trace without problem.

It seems this issue should be fixed in Linus' tree now.

Can you confirm it's fixed?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

