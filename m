Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288113AbSA0QPT>; Sun, 27 Jan 2002 11:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288114AbSA0QPJ>; Sun, 27 Jan 2002 11:15:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:28307 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288113AbSA0QPC>;
	Sun, 27 Jan 2002 11:15:02 -0500
Date: Sun, 27 Jan 2002 17:09:55 +0100
From: Dave Jones <davej@suse.de>
To: Tomasz Wegrzanowski <taw@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compilation problems
Message-ID: <20020127170955.C17005@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Tomasz Wegrzanowski <taw@users.sf.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020127153829.GA18621@tavaiah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020127153829.GA18621@tavaiah>; from taw@users.sf.net on Sun, Jan 27, 2002 at 04:38:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 04:38:29PM +0100, Tomasz Wegrzanowski wrote:
 > drivers/sound/sounddrivers.o(.data+0xb4): undefined reference to `local symbols in discarded section .text.exit'
 > I also couldn't compile 2.5.2
 > On the other hand 2.5.2-dj5 works. That's weird.

 It's because my tree has Keith Owens' text.exit changes, and
 also the related __devexitp changes. I'll push these to Linus
 soon.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
