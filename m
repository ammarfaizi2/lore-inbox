Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281559AbRKPVrW>; Fri, 16 Nov 2001 16:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281566AbRKPVrS>; Fri, 16 Nov 2001 16:47:18 -0500
Received: from mail207.mail.bellsouth.net ([205.152.58.147]:6350 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281568AbRKPVqt>; Fri, 16 Nov 2001 16:46:49 -0500
Message-ID: <3BF5892C.171CF4DD@mandrakesoft.com>
Date: Fri, 16 Nov 2001 16:46:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111162219170.22827-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> +               /* If we get here, it's not a certified SMP capable AMD system. */
> +               printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
> +               tainted |= (1<<2);
> +

having a constant instead of setting magic bit 2 would be nice

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

