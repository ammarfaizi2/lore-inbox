Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWHMPah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWHMPah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 11:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHMPah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 11:30:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23308 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751287AbWHMPag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 11:30:36 -0400
Date: Sun, 13 Aug 2006 17:30:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: 2.6.18-rc4-mm1: drivers/video/sis/ compile error
Message-ID: <20060813153034.GD3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
> +drivers-video-sis-sis_mainh-removal-of-old.patch
>...
>  fbdev updates
>...

This patch removes too much:

<--  snip  -->

...
  CC      drivers/video/sis/sis_main.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c: 
In function ‘sisfb_setdefaultparms’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:91: 
error: ‘sisfb_mode_idx’ undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:91: 
error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:91: 
error: for each function it appears in.)
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c: 
In function ‘sisfb_search_vesamode’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:129: 
error: ‘sisfb_mode_idx’ undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c: 
In function ‘sisfb_search_mode’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:172: 
error: ‘sisfb_mode_idx’ undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c: 
In function ‘sisfb_probe’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/drivers/video/sis/sis_main.c:5813: 
error: ‘sisfb_mode_idx’ undeclared (first use in this function)
make[4]: *** [drivers/video/sis/sis_main.o] Error 1

<--  snip  -->

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

