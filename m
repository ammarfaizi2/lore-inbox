Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271228AbTHHFqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 01:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271229AbTHHFqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 01:46:12 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:56762 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S271228AbTHHFqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 01:46:10 -0400
Date: Fri, 8 Aug 2003 07:46:05 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20030808054604.GA1905@spaans.vs19.net>
References: <20030807180032.GA16957@spaans.vs19.net> <1060295842.3169.83.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1060295842.3169.83.camel@dhcp22.swansea.linux.org.uk>
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor', torvalds@osdl.org
Content-Type: text/plain; charset=iso-8859-15
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 11:37:23PM +0100, Alan Cox wrote:
> > It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
> > I've just comiled all affected files (that is, the config resulting from
> > make allyesconfig minus already broken stuff) succesfully on i386.
> 
> The Linux kernel tended to favour european spelling, and favOUr is
> indeed correct English.

Personally, I prefer the european flavour too.

However, a quick count on the original tree shows:

spaans@spaans:~/bk/export$ grep -ir 'flavour' . |wc -l
     74
spaans@spaans:~/bk/export$ grep -ir 'flavor' . |wc -l
    192

which is why I chose to do it this way.

There's no reason to not do it the other way around, of course.

VrGr,
-- 
Jasper Spaans                 http://jsp.vs19.net/contact/
