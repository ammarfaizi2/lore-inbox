Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131330AbRAVAWe>; Sun, 21 Jan 2001 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131387AbRAVAWY>; Sun, 21 Jan 2001 19:22:24 -0500
Received: from p160.as-l001.contactel.cz ([212.65.194.160]:13440 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S131330AbRAVAWN>;
	Sun, 21 Jan 2001 19:22:13 -0500
Date: Mon, 22 Jan 2001 01:18:51 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: display problem with matroxfb
Message-ID: <20010122011851.D1152@ppc.vc.cvut.cz>
In-Reply-To: <200101211448.PAA07015@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101211448.PAA07015@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Sun, Jan 21, 2001 at 03:48:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 03:48:44PM +0100, f5ibh wrote:
> Hi !
> 
> I've a matrox mystique with 8Mb RAM.
> I've a problem when I use matroxfb instead vesafb.
> If I enable CONFIG_FB_VESA, I get the nice logo and all is right for me.
> If I enable CONFIG_FB_MATROX, the beginning of each line is in the middle
> of the screen and the cursor position does not match the prompt position.
> Nevetheless, the screen is 'readable' (no garbage). I've read the files
> in ../Documentation/fb and the Framebuffer-HOWTO.

Are you sure that you did not enabled both vesafb and matroxfb? They cannot
work together. Also, does this happen only in 8bpp mode, or does this
happen in other color depths too?
						Petr Vandrovec
						vandrove@vc.cvut.cz


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
