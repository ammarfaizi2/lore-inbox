Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWC0BSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWC0BSz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 20:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWC0BSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 20:18:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:14991 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751171AbWC0BSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 20:18:54 -0500
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060327004741.GA19187@MAIL.13thfloor.at>
References: <20060327004741.GA19187@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 12:17:21 +1100
Message-Id: <1143422242.3589.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 02:47 +0200, Herbert Poetzl wrote:
> Hey Ben!
> 
> 2.6.16 and 2.6.15-something show a funny behaviour
> when using the radeonfb driver (for text mode), they
> kind of twist and break the fonts in various places
> some characters or parts seem to be mirrored like
> '[' becoming ']' but not on character boundary but
> more on N pixels, colors seem to be correct for the
> characters, and sometimes the font is perfectly fine
> for larger runs, e.g. I can read the logon prompt
> fine, but everything I type is garbled ...
> 
> just for an example, when I type 'echo "Test"' then
> all characters are mirrored and cut off on the right
> side but the locations are as shown above, on enter
> the T is only a few pixels wide, but the est part is
> written perfectly fine ... this is a new behaviour
> and going back to 2.6.13.3 doesn't show this ...
> 
> if there is some testing I can do for you, or when
> you need more info, please let me know. here a few
> details for the machine:

I have a similar machine and haven't seen such a problem with it so
far ... does this happen after you load X or already at boot before X
ever kicks in ? Does it happen if you don't load any font (that is for
example boot with init=/bin/sh to prevent any init script to try to load
a font)

Ben.


