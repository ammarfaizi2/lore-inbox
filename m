Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313173AbSEEQVg>; Sun, 5 May 2002 12:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313179AbSEEQVf>; Sun, 5 May 2002 12:21:35 -0400
Received: from bitmover.com ([192.132.92.2]:23483 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313173AbSEEQVf>;
	Sun, 5 May 2002 12:21:35 -0400
Date: Sun, 5 May 2002 09:21:33 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Guest section DW <dwguest@win.tue.nl>,
        Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: UML is now self-hosting!
Message-ID: <20020505092133.L18594@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Dike <jdike@karaya.com>, Mike Fedyk <mfedyk@matchmail.com>,
	Guest section DW <dwguest@win.tue.nl>,
	Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net
In-Reply-To: <20020505082505.GE2392@matchmail.com> <200205051225.HAA01629@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2002 at 07:25:00AM -0500, Jeff Dike wrote:
> mfedyk@matchmail.com said:
> > How would this be better than MOSIX, or other clustering solutions? 
> 
> MOSIX (or Compaq's SSI) would certainly be a way of doing it.  It happens
> that there's a particularly simple way of doing it with UML.  You'd partition
> UML's 'physical' memory between the hosts, and use the fact that those pages
> are really virtual to fault them between hosts as needed.  This would perform
> particularly badly, but its simplicity appeals to me.

See http://www.bitmover.com/cc-pitch/ for some more on this idea.  I think 
the UML approach would be very cool.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
