Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSKBWK5>; Sat, 2 Nov 2002 17:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSKBWK5>; Sat, 2 Nov 2002 17:10:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42503 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261451AbSKBWK4>;
	Sat, 2 Nov 2002 17:10:56 -0500
Date: Sat, 2 Nov 2002 23:16:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: make clean broken in 2.5.45
Message-ID: <20021102221605.GA14040@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20021101211207.GA238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101211207.GA238@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 10:12:08PM +0100, Pavel Machek wrote:
> Hi!
> 
> make clean; time make bzImage took one minute for me. That's *not*
> right. rm `find . -name "*.o"` resulted in >5 minutes compilation
> time.
I have tried to reproduce this without luck.
make defconfig
make
make clean
find -name '*.o' did not show any .o files.

Could you please try to list the .o files that survive a make clean.
If there are any then I would like to have a copy of .config as well.

	Sam
