Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313139AbSDDL6m>; Thu, 4 Apr 2002 06:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313147AbSDDL6d>; Thu, 4 Apr 2002 06:58:33 -0500
Received: from ns.suse.de ([213.95.15.193]:21775 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313139AbSDDL6S>;
	Thu, 4 Apr 2002 06:58:18 -0500
Date: Thu, 4 Apr 2002 13:58:17 +0200
From: Dave Jones <davej@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new fbdev api.
Message-ID: <20020404135817.Q20040@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Simmons <jsimmons@transvirtual.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10204031224280.14670-100000@www.transvirtual.com> <Pine.GSO.4.21.0204040949550.28139-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 09:50:09AM +0200, Geert Uytterhoeven wrote:
 > > This will have a very important impact on linux embedded devices. It has
 > > been tested and has been in Dave Jones tree for some time. Geert with
 > > your blessing I like to have it added to Linus tree.
 > 
 > Please go ahead!

Indeed, the fb changes are the largest chunk of -dj right now.
The three heavy-weight patches pending integration by their maintainers
make up for half of whats left to be resynced..

(davej@noodles:resync)$ ll new-*
-rw-r--r--    1 davej    users      527576 Apr  1 21:48 new-console-layer.diff
-rw-r--r--    1 davej    users     2005697 Apr  1 03:12 new-fbdev.diff
-rw-r--r--    1 davej    users      396297 Apr  1 19:01 new-input-layer.diff


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
