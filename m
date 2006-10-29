Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965302AbWJ2RZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbWJ2RZg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbWJ2RZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:25:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54534 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965302AbWJ2RZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:25:36 -0500
Date: Sun, 29 Oct 2006 18:25:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: predator@mt9.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: -W -Wno-unused -Wno-sign-compare compile flags
Message-ID: <20061029172535.GG27968@stusta.de>
References: <web-577743@televic-cs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <web-577743@televic-cs.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 05:22:48PM +0300, predator@mt9.ru wrote:
> Hello !linux-kernel
> 
> Does anybody try to compile latest linux-kernel with -W 
> -Wno-unused -Wno-sign-compare CFLAGS? There is a tons of 
> warnings :(
> Recent versions of grsecurity patches adds this flags to 
> default. When I asked to grsec developers, why did they do 
> that, they answered: to show, how messy linux code is...
> Is there any objections about it?

-W gives many warnings, some of them indicate possible improvements 
while some of them warn about things that are perfectly OK.

While getting such warnings is a task that is sometimes worked on, it's 
neither realistic nor required to get all warnings with -W fixed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

