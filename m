Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUKHXJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUKHXJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUKHXJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:09:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39954 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261289AbUKHXJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:09:31 -0500
Date: Tue, 9 Nov 2004 00:08:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-os@analogic.com
Cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108230859.GL15077@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org> <20041108183120.GB15077@stusta.de> <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com> <20041108212713.GH15077@stusta.de> <Pine.LNX.4.61.0411081640320.8258@chaos.analogic.com> <20041108222952.GJ15077@stusta.de> <Pine.LNX.4.61.0411081751500.8711@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411081751500.8711@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 05:57:12PM -0500, linux-os wrote:
>...
> 	call	strcpy
>...
> strcpy:
> 	subl	$8, %esp
>...
> It clearly invents strcpy, having never been referenced in the
> source.

The asm code you sent does _not_ call a global strcpy function.
It calls an asm procedure named "strcpy" it ships itself.

BTW: You are the second person in this thread I have to explain this to...

> Cheers,
> Dick Johnson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

