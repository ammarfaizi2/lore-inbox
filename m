Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271909AbTGRWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271903AbTGRWfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:35:43 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:61963 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270373AbTGRWdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:33:38 -0400
Date: Sat, 19 Jul 2003 00:48:33 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Michael Still <mikal@stillhq.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH] docbook: Added support for generating man files
Message-ID: <20030719004833.A3174@pclin040.win.tue.nl>
References: <1058565240.19558.91.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0307190828070.1829-100000@diskbox.stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307190828070.1829-100000@diskbox.stillhq.com>; from mikal@stillhq.com on Sat, Jul 19, 2003 at 08:36:27AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 08:36:27AM +1000, Michael Still wrote:

> > IS there any chance it could incorporate the GPL by a slightly smaller
> > reference or even a link for the HTML one, it looks great except that
> > 90% of the manual page is a GPL each time 8)

> Well, the only part which comes from this patch is:
> ... Michael Still (mikal\@stillhq.com) ...
> ... This documentation was generated with kernel version $ARGV[2]. ...
> I can shorten this if people would like.

Commenting on the man page (nroff) version:

Please put the mikal\@stillhq.com in a comment.
Please leave the kernel version.

> The GPL bit people have commented on is actually extracted from the front
> matter of the SGML file being converted inside
> <legalnotice></legalnotice>. Therefore, if the SGML kerneldoc output we
> already have includes the GPL, then so does the man page. I have not
> imposed new license conditions on the documentation.
> 
> If people are comfortable with dropping the legal notice, or perhaps 
> inserting a line saying "refer to file X for the license on this 
> documentation", then I'll do that and send a new patch.

Please put all legalities in comments - behind .\" we do not have to read
them, but they are there if anyone cares.

Andries

