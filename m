Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271522AbRHZW3m>; Sun, 26 Aug 2001 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271557AbRHZW3c>; Sun, 26 Aug 2001 18:29:32 -0400
Received: from cs666814-138.austin.rr.com ([66.68.14.138]:384 "EHLO
	granite.internal") by vger.kernel.org with ESMTP id <S271522AbRHZW3X>;
	Sun, 26 Aug 2001 18:29:23 -0400
Date: Sun, 26 Aug 2001 17:30:58 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Olaf Hering <olh@suse.de>
Subject: Re: scr_*() audit
Message-ID: <20010826173058.A1418@austin.ibm.com>
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg>; from geert@linux-m68k.org on Wed, Aug 22, 2001 at 07:06:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 07:06:12PM +0200, Geert Uytterhoeven wrote:
> 
> Since there are still some issues left with the scr_*() functions on
> big-endian platforms that can have both VGA and frame buffer consoles, I
> decided to spent some precious time on auditing the usage of these functions.

Much appreciated.

For the record, this resolves my problems with VGA console (only; no fb) on
PPC. Previously text written to non-active consoles was endian-reversed.

If no one has any problems (anyone else tested it?), could this patch please
be committed?

-Hollis
