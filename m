Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTGRWXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270383AbTGRWXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:23:23 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:58599 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP id S271927AbTGRWVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:21:08 -0400
Date: Sat, 19 Jul 2003 08:36:27 +1000
From: Michael Still <mikal@stillhq.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH] docbook: Added support for generating man files
In-Reply-To: <1058565240.19558.91.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307190828070.1829-100000@diskbox.stillhq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2003, Alan Cox wrote:

Hey,

thanks to Sam, Andries and yourself for showing an interest in the patch.

> On Gwe, 2003-07-18 at 22:23, Sam Ravnborg wrote:
> > Hi Linus - please apply. Only docbook relevant changes [with patch this time].
> > 
> > Originally by Michael Still <mikal@stillhq.com>
> >  
> > This patch adds two new targets to the docbook makefile -- mandocs, and
> 
> IS there any chance it could incorporate the GPL by a slightly smaller
> reference or even a link for the HTML one, it looks great except that
> 90% of the manual page is a GPL each time 8)

Well, the only part which comes from this patch is:

<para>
If you have comments on the formatting of this manpage, then please contact
Michael Still (mikal\@stillhq.com).
</para>

<para>
This documentation was generated with kernel version $ARGV[2].
</para>

I can shorten this if people would like.

The GPL bit people have commented on is actually extracted from the front
matter of the SGML file being converted inside
<legalnotice></legalnotice>. Therefore, if the SGML kerneldoc output we
already have includes the GPL, then so does the man page. I have not
imposed new license conditions on the documentation.

If people are comfortable with dropping the legal notice, or perhaps 
inserting a line saying "refer to file X for the license on this 
documentation", then I'll do that and send a new patch.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | Stage 1: Steal underpants
http://www.stillhq.com            | Stage 2: ????
UTC + 10                          | Stage 3: Profit

