Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbTLSJlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 04:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTLSJlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 04:41:22 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:8144 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S262190AbTLSJlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 04:41:19 -0500
Date: Fri, 19 Dec 2003 10:41:16 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Steffen Schwientek <schwientek@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
Message-ID: <20031219094116.GB13559@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <200312190314.13138.schwientek@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312190314.13138.schwientek@web.de>
X-Operating-System: vega Linux 2.6.0-test11 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, as I should have noticed, matrox framebuffer is totally UNUSABLE
with any 2.6.0-test kernels ;-( Several problems occured, like no
picture all, unstable picture, corruption on screen all the times, crashes,
etc. Both with G400 and G200. Everything works with 2.4.x kernel though.
This is the major point I can't upgrade to 2.6.0 ...
Maybe somebody try to port fb layer of 2.4.x to 2.6? I write this because
AFAIK in 2.6 there were a major rewrite of framebuffer support 'needed
for the embedded industry' (or something similar). As I've noticed,
somebody even thinks that framebuffer is only used for 'getting the
tux logo'. But I really need it, because of playing video on framebuffer
probably with multiple heads, hardware acceleration etc etc etc ...

On Fri, Dec 19, 2003 at 03:14:13AM +0100, Steffen Schwientek wrote:
> My Matrox-framebuffer is not working properly. Build direct into the
> kernel, the monitor will be black with some stripes at startup, just the
> reset button works.
> Build as a modules, the same happens if I load the module.
> 
> The make xconfig script also advice me to compile some 8,16,24 and 32 bpp
> packed pixel too, but I cant find them in the 2.6 kernel configuration
> 
> Steffen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- Gábor (larta'H)
