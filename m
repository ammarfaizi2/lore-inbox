Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTDDOBW (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTDDN6Q (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:58:16 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56456
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263666AbTDDNyf (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:54:35 -0500
Subject: Re: [PATCH] interlaced packed pixels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0304041418000.1720-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0304041418000.1720-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049461651.2138.70.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Apr 2003 14:07:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-04 at 13:22, Geert Uytterhoeven wrote:
> Op vrijdag 4 April 2003, schreef Alan Cox:
> > On Gwe, 2003-04-04 at 12:17, Geert Uytterhoeven wrote:
>      ^^^                                          ^^^^^
> The Welsh setup isn't 100% finished yet ;-)

Translations in progess still. Tackling evolution is a big job
that the translators haven't started yet

> What's the exact format description for MJPEG? YUV 4:*:*?
> Shouldn't that be a FB_VISUAL_MJPEG?

The frame buffer holds a jpeg frame. At the moment text mode
is problematic but doable (you encode each dct square the
same size for each charater and write in a carefully sized font 8))

