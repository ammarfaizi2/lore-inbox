Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUHFNqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUHFNqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUHFNqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:46:19 -0400
Received: from witte.sonytel.be ([80.88.33.193]:55483 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267524AbUHFNqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:46:16 -0400
Date: Fri, 6 Aug 2004 15:45:16 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Vrabel <dvrabel@arcom.com>
cc: Hollis Blanchard <hollisb@us.ibm.com>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: cross-depmod?
In-Reply-To: <411343F9.1080301@arcom.com>
Message-ID: <Pine.GSO.4.58.0408061540200.26252@waterleaf.sonytel.be>
References: <1091742716.28466.27.camel@localhost> <411343F9.1080301@arcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, David Vrabel wrote:
> Hollis Blanchard wrote:
> > My problem is that I cross-build my kernels, and 'make rpm' is very
> > unhappy when it can't use depmod. I know that I can do 'make
> > DEPMOD=/bin/true rpm', but can't we figure that out automatically?
>
> I'd suggest not running depmod when building an RPM but instead run it
> as part of the RPMs post-installation script.

I guess Hollis (just like me) is mostly interested in the possible error
messages of depmod, due to missing exported symbols.

Hollis: I asked the same question about six months year ago, cfr. the thread at
http://seclists.org/lists/linux-kernel/2004/Feb/3527.html

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
