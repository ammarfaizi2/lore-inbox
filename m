Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSA3KWh>; Wed, 30 Jan 2002 05:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289067AbSA3KWS>; Wed, 30 Jan 2002 05:22:18 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:50693 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289058AbSA3KV6>; Wed, 30 Jan 2002 05:21:58 -0500
Date: Wed, 30 Jan 2002 10:21:47 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev accel wrapper. II
Message-ID: <20020130102147.C16937@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.21.0201291034460.3801-100000@vervain.sonytel.be> <Pine.LNX.4.10.10201291507020.29648-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201291507020.29648-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Tue, Jan 29, 2002 at 03:59:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 03:59:26PM -0800, James Simmons wrote:
>     if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
>         region.color = attr_bgcol_ec(p,vc);
>     else 
>         region.color = info->pseudo_palette)[attr_bgcol_ec(p,vc)];
                        ^                    ^

I hope this is a typing mistake that's not present in the real source. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

