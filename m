Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSGINK3>; Tue, 9 Jul 2002 09:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGINJB>; Tue, 9 Jul 2002 09:09:01 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:23787 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315222AbSGINIj>; Tue, 9 Jul 2002 09:08:39 -0400
Date: Tue, 9 Jul 2002 05:16:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Re: user-mode port 0.58-2.4.18-36
Message-ID: <20020709031618.GC113@elf.ucw.cz>
References: <20020706011643.GD112@elf.ucw.cz> <200207062303.SAA02760@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207062303.SAA02760@ccure.karaya.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So... what prevents uml root from inserting rogue module (perhaps
> > using /dev/kmem) and escape the jail? 
> 
> That's prevented by the admin taking basic precautions and turning on 'jail',
> which refuses to run if module support is present and which also disables
> writing to /dev/kmem.

...and using CAP_SYS_RAWIO...
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
