Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUCPPjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUCPPjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:39:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:9148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263118AbUCPPiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:38:10 -0500
Date: Tue, 16 Mar 2004 07:37:19 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, bos@serpentine.com,
       linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
Message-ID: <20040316153719.GA13723@kroah.com>
References: <4056B0DB.9020008@pobox.com> <20040316005229.53e08c0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316005229.53e08c0c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 12:52:29AM -0800, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > Too big to post,
> > 
> >  http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.5-rc1-klibc1.patch.bz2
> >  	or
> >  bk://kernel.bkbits.net/jgarzik/klibc-2.5
> > 
> >  IIRC, this is:  my update of Bryan O'Sullivan's update of Greg KH's 
> >  update of my merge of hpa's and viro's hacking :)
> > 
> >  WRT overall klibc merge:  when it can do md RAID autorun, it's 
> >  mergeable.  And didn't somebody write a tiny mdctl program...
> 
> It's so long since klibc was discussed (ie: more than five minutes ago)
> that I forget the reasons why it should be delivered via the kernel tree.
> 
> Remind me please?

We need a way to build the userspace programs that get put into
initramfs that will be needed to boot the kernel.

That help?

thanks,

greg k-h
