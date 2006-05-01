Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWEAPHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWEAPHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWEAPHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:07:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:64222 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932132AbWEAPHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:07:43 -0400
Date: Mon, 1 May 2006 08:05:50 -0700
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/4] MultiAdmin module
Message-ID: <20060501150550.GA8328@kroah.com>
References: <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr> <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr> <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr> <Pine.LNX.4.61.0605011549460.31804@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605011549460.31804@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 03:50:21PM +0200, Jan Engelhardt wrote:
> 
> [PATCH 4/4] MultiAdmin module
> 
>     -   Add the MultiAdmin to the mainline tree.
>         I hope the rest is self-explanatory.
> 
> Please do not mention CodingStyle for multiadm.c. I already know it. :)
> And I will get to it should it really be merged.

No one will review it if it isn't in the proper CodingStyle.

We have a coding style for a reason, it makes it a very simple thing for
anyone to review the code as the patterns are all the same.  It turns
out that people's brains get trained to ignore the patterns and see the
details instead.  Lots of research backs this up.

So switch to the common coding style, otherwise no one will look at your
code (or if they do, odds are they will miss a lot...)

thanks,

greg k-h
