Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281753AbRKRX31>; Sun, 18 Nov 2001 18:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281776AbRKRX3R>; Sun, 18 Nov 2001 18:29:17 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:43906 "HELO
	mail.temp123.org") by vger.kernel.org with SMTP id <S281753AbRKRX3F>;
	Sun, 18 Nov 2001 18:29:05 -0500
Date: Sun, 18 Nov 2001 18:29:03 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird PCMCIA behavior
Message-ID: <20011118182903.A18291@temp123.org>
In-Reply-To: <20011118180656.A18252@temp123.org> <3BF84297.7FB77B3B@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF84297.7FB77B3B@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Nov 18, 2001 at 06:21:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 06:21:59PM -0500, Jeff Garzik wrote:

> pcmcia-cs problems are reported to http://pcmcia-cs.sourceforge.net/
> We encourage you to use the kernel's cardbus code instead :)
> (CONFIG_PCMCIA and CONFIG_CARDBUS)

That's what I'm using to get these errors.  I think, although I haven't
fully tested yet, that pcmcia-cs's core works fine in all power states.

> As a side note, with kernel cardbus support, you should no longer need
> external utilities or external drivers.  It should Just Work(tm).

Do I not still need the cardmgr and all that rot from pcmcia-cs ?  That's
what I've been using for detection, bind cards to specific modules, etc.

-- 
Josh Litherland (fauxpas@temp123.org)
