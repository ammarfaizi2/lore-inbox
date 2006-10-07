Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932863AbWJGVKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbWJGVKx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 17:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWJGVKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 17:10:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14087 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932863AbWJGVKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 17:10:52 -0400
Date: Sat, 7 Oct 2006 23:10:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 SMP x86_64 boot hungs up
Message-ID: <20061007211046.GA8810@stusta.de>
References: <20061005143237.xr08e3ew5b2ocgc8@69.222.0.225> <20061005212029.GL16812@stusta.de> <20061006162435.jwb4n5zrl68sow4w@69.222.0.225>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006162435.jwb4n5zrl68sow4w@69.222.0.225>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 04:24:35PM -0500, art@usfltd.com wrote:
> 
> 
> $ git-bisect bad 265baba316ea258ca015aa79bc6f107cd9fce2b3 is first bad commit
> commit 265baba316ea258ca015aa79bc6f107cd9fce2b3
> Author: Andi Kleen <ak@suse.de>
> Date:   Tue Sep 26 10:52:26 2006 +0200
> 
>      [PATCH] Update defconfig
> 
>      Signed-off-by: Andi Kleen <ak@suse.de>
> 
> :040000 040000 2c37b438987d915eb3eb10756f0f2a9239167a65  
> 5be110cee7f07799703a24a2493605b4a1527fb7 M      arch
> 
> 
> any clue ?

First of all thanks for your testing.

Are you using the defconfig (instead of your own .config) on your 
computer?

If not, it seems something else (e.g. an unrelated temporary error) 
interfered with your bisecting, and I do not have any clue.  :-(

> xboom

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

