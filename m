Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWHYHPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWHYHPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWHYHP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:15:29 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:34744 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751119AbWHYHP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:15:28 -0400
Date: Fri, 25 Aug 2006 09:19:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Adrian Bunk <bunk@stusta.de>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060825071955.GA30453@uranus.ravnborg.org>
References: <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org> <20060824160926.GM19810@stusta.de> <20060824164752.GC5205@martell.zuzino.mipt.ru> <20060824170709.GO19810@stusta.de> <1156439763.3012.155.camel@pmac.infradead.org> <20060824103459.77e5569c.rdunlap@xenotime.net> <1156441724.3012.183.camel@pmac.infradead.org> <20060824175922.GA22586@uranus.ravnborg.org> <Pine.LNX.4.61.0608250822090.7912@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608250822090.7912@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:23:28AM +0200, Jan Engelhardt wrote:
> >
> >Here meuconfig can be a great help for you. Trying the help option
> >tells you a bit more about what needs to be done to disable
> >a given option.
> 
> Some nitpick: when there are a lot of dependencies or a long select 
> or long selected by list, you need to scroll far to the right, and possibly 
> back left again. This takes time because the normal user set a keyboard 
> repeat rate at about 30. (Under X, I prefer 35, but that's unfortunately 
> not available on 80x25/console/tty1.)
> These lines should be wrapped

One day when I feel in the right mode I will try to cook up something
so you can get a menu where you can change the individual items referend for
a symbol.
This should allow you to say N to all selected symbols except the symbols
that is selected where you have to take one step deeper in the hirachy.

But there are more exiting project ahead than just this one so...

	Sam
