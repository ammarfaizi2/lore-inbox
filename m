Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVCKW7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVCKW7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVCKW65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:58:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2565 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261802AbVCKWuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:50:20 -0500
Date: Fri, 11 Mar 2005 23:50:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jurriaan <thunder7@xs4all.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2 fremap.c compile error
Message-ID: <20050311225008.GP3723@stusta.de>
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050308185411.GA17977@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308185411.GA17977@middle.of.nowhere>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 07:54:11PM +0100, Jurriaan wrote:

> mm/fremap.c:33:48: macro "flush_cache_page" passed 3 arguments, but takes just 2
> mm/fremap.c: In function `zap_pte':
> mm/fremap.c:33: error: `flush_cache_page' undeclared (first use in this function)
> mm/fremap.c:33: error: (Each undeclared identifier is reported only once
> mm/fremap.c:33: error: for each function it appears in.)
> mm/fremap.c:34:55: macro "ptep_get_and_clear" passed 3 arguments, but takes just 1
> mm/fremap.c:34: error: `ptep_get_and_clear' undeclared (first use in this function)
> mm/fremap.c:48:41: macro "pte_clear" passed 3 arguments, but takes just 1
> mm/fremap.c:48: error: `pte_clear' undeclared (first use in this function)
> mm/fremap.c: In function `install_page':
> mm/fremap.c:97: warning: implicit declaration of function `set_pte_at'
> make[1]: *** [mm/fremap.o] Error 1
> make: *** [mm] Error 2
>  
> The same config worked fine for 2.6.11-mm1:
>...

I wasn't able to reproduce this with your .config .

Are you using a completely otherwise unpatched 2.6.11-mm2?
Please retry with a freshly unpacked 2.6.11 plus the -mm2 patch.

> Good luck,
> Jurriaan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

