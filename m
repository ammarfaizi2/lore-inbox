Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUIJLJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUIJLJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUIJLJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:09:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60422 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267363AbUIJLJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:09:54 -0400
Date: Fri, 10 Sep 2004 12:09:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
Message-ID: <20040910120950.D22599@flint.arm.linux.org.uk>
Mail-Followup-To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	linux-kernel@vger.kernel.org
References: <20040910110819.GE14060@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040910110819.GE14060@lkcl.net>; from lkcl@lkcl.net on Fri, Sep 10, 2004 at 12:08:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 12:08:19PM +0100, Luke Kenneth Casson Leighton wrote:
> hi,
> 
> has anyone noticed that it's impossible (without hacking) to remove
> CONFIG_SERIAL?
> 
> remove the entries or set all SERIAL config entries to "n"...
> hit make...
> CONFIG_SERIAL_8250 gets set to "m", CONFIG_SERIAL gets set to "y"!
> 
> seeerrrriiialllll muuuusssstttt dieeeeeee kill kill kill.

No idea - you've given very little information to go on.  I doubt
you're building an x86 kernel... Mind giving some clues and maybe
a copy of your .config file?

I regularly moan about overuse of the Kconfig "select" statement
and at a guess you've just been bitten by this.  Feel free to moan
like merry hell about it.

> there are 64 serial devices created.

Why are you seeing 64 serial devices created?  You should only see
about 16 or so in most sane configurations.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
