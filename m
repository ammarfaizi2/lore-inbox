Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUABUly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUABUly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:41:54 -0500
Received: from august.skynet.be ([195.238.3.60]:1969 "EHLO august.skynet.be")
	by vger.kernel.org with ESMTP id S265658AbUABUlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:41:52 -0500
Date: Fri, 2 Jan 2004 21:39:17 +0100
From: "T'aZ" <taz-007@skynet.be>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev - please help me to understand
Message-Id: <20040102213917.03efda14.taz-007@skynet.be>
In-Reply-To: <20040102202125.GC4992@kroah.com>
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org>
	<20040102123636.GA29909@mark.mielke.cc>
	<20040102202125.GC4992@kroah.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (august.skynet.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jan 2004 12:21:25 -0800
Greg KH <greg@kroah.com> wrote:

> On Fri, Jan 02, 2004 at 07:36:36AM -0500, Mark Mielke wrote:
> > 
> > Personally, I like the idea of having a clean /dev where names only
> > exist for devices that I care about. On my Fedora Core 1 box, it looks
> > like /dev is currently:
> > 
> >     $ ls /dev | wc -l
> >        7528
> > 
> > Seven *THOUSAND* five hundred and twenty eight. Sheesh. I probably only
> > use a few dozen, or maybe even a few hundred, but definately not 7000+.
> 
> You missed all of the subdirectories.  Here's what FC-1 has on my laptop:
> 	$ tree /dev/ | tail -1
> 	41 directories, 18721 files
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
T'aZ |Jabber:taz-007@jabber.org|GPG keyID:E051925D|http://taz.prout.be
*They that can give up essential liberty to obtain a little temporary
 safety deserve neither liberty nor safety.*  Benjamin Franklin 1759
*Beaucoup,vite,loin,mal.*  http://www.cl.cam.ac.uk/~rja14/tcpa-faq.html
