Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271359AbTHHGwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271362AbTHHGwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:52:40 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:63419 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S271359AbTHHGwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:52:39 -0400
Date: Fri, 8 Aug 2003 08:52:30 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <20030808065230.GA5996@spaans.vs19.net>
References: <20030807180032.GA16957@spaans.vs19.net> <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com>
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Content-Type: text/plain; charset=iso-8859-15
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 09:42:37PM -0400, Zwane Mwaikambo wrote:

> > It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
> > I've just comiled all affected files (that is, the config resulting from
> > make allyesconfig minus already broken stuff) succesfully on i386.
> 
> Arrrgh! You can't be serious!

Yes, I am bloody serious; this patch might look purely cosmetic at first
sight.. yet, there's a technical reason for at least one part of it. Grep
and see the horror:

$ egrep -ni 'flavou?r' fs/nfs/inode.c
[snip]
1357:	rpc_authflavor_t authflavour;
[snip]

VrGr,
-- 
Jasper Spaans                 http://jsp.vs19.net/contact/
