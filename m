Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUFWQVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUFWQVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUFWQT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:19:27 -0400
Received: from palrel12.hp.com ([156.153.255.237]:34228 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265281AbUFWQQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:16:12 -0400
Date: Wed, 23 Jun 2004 09:16:07 -0700
To: James Ketrenos <jketreno@linux.jf.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Joshua Kwan <jkwan@rackable.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What happened to linux/802_11.h?
Message-ID: <20040623161607.GA15996@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <pan.2004.06.21.22.25.18.591967@triplehelix.org> <20040621173827.0403618b.akpm@osdl.org> <20040622004813.GA12334@bougret.hpl.hp.com> <40D8DF60.1090803@linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D8DF60.1090803@linux.jf.intel.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 08:39:44PM -0500, James Ketrenos wrote:
> Jean Tourrilhes wrote:
> 
> >On Mon, Jun 21, 2004 at 05:38:27PM -0700, Andrew Morton wrote:
> > 
> >
> >>Joshua Kwan <jkwan@rackable.com> wrote:
> >>   
> >>
> >>>The IPW2100 driver
> >>>(http://ipw2100.sourceforge.net) uses its definitions and now won't build
> >>>against -bk or -mm kernel source.
> >>>     
> >>>
> >>Jean, should we restore 802_11.h, or is there some alternative file which
> >>that driver should be using?
> >>   
> >>
> >
> >	Well, Jeff explicitely said that we should not care about
> >drivers outside the kernel ;-)
> >	Seriously, I see three solutions :
> >	1) Convert ipw2100 to using drivers/net/wireless/ieee802_11.h,
> >extend this header as necessary
> > 
> >
> This is the path I was planning to take when I read about 802_11.h 
> possibly going away a while ago.  The file finally going away will just 
> raise the priority of that effort a bit :)  Changing the code to use the 
> headers in drivers/net/wireless isn't a big task -- I'll put the change 
> into the next snapshot of ipw2100.

	Nice. I saw that Joshua already sent a patch on your mailing
list.
	BTW, I'm not the one maintaining ieee802_11.h, it was
originally created by David Gibson as part of the Orinoco driver. So,
if there is something you don't like in it, you may want to contact
him.

> Thanks,
> James

	Have fun...

	Jean
