Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263877AbTEFRsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTEFRsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:48:08 -0400
Received: from dialpool-210-214-80-240.maa.sify.net ([210.214.80.240]:10368
	"EHLO softhome.net") by vger.kernel.org with ESMTP id S263877AbTEFRrd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:47:33 -0400
Date: Tue, 6 May 2003 23:28:51 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Russell King <rmk@arm.linux.org.uk>, andyp@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: Missing logo?
Message-ID: <20030506175851.GA4370@localhost.localdomain>
References: <20030506180707.B15174@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506180707.B15174@flint.arm.linux.org.uk>
X-GPG-Fingerprint: A977 433E B71E 2D1C 6114  9F33 F390 527D 70D1 2799
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 06:07:07PM +0100, Russell King wrote:
> Hi,
> 
> I seem to have a penguin missing in action, somewhere between 2.5.68 and
> 2.5.69.  Has anyone else lost a penguin under similar circumstances?
> 
> $ grep LOGO linux-sa1100/.config
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y
> 
> Other than the missing logo, the fb display looks as it did under 2.5.68.
> 
> assabet$ fbset
> 
> mode "320x240-60"
>         geometry 320 240 320 240 16
>         timings 171521 61 9 3 0 5 1
>         accel false
>         rgba 5/11,6/5,5/0,0/0
> endmode
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Me too. I think it happens with all configs. The empty space is there
for the penguin but I guess it gets eaten somewhere on the way.
-- 
