Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUHBWi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUHBWi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUHBWi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:38:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:49322 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264377AbUHBWfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:35:52 -0400
Date: Mon, 2 Aug 2004 15:10:47 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       dsaxena@plexity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] Add Intel IXP2400 & IXP2800 to PCI.ids
Message-ID: <20040802221047.GA15007@kroah.com>
References: <20040716170832.GA4997@plexity.net> <40F81020.5010808@pobox.com> <20040716194654.GA20555@redhat.com> <20040716200113.GB20555@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716200113.GB20555@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 09:01:13PM +0100, Dave Jones wrote:
> On Fri, Jul 16, 2004 at 08:46:54PM +0100, Dave Jones wrote:
>  > On Fri, Jul 16, 2004 at 01:28:00PM -0400, Jeff Garzik wrote:
>  > 
>  >  > >This is already in sf.net, just not upstream.
>  >  > 
>  >  > Why not post a patch updating to latest sf.net?
>  >  > 
>  >  > We really need to keep the two in sync.
>  > 
>  > This could be trivially automated to have a script
>  > grab latest, generate diff, and send a mail to Linux-kernel
>  > once a week/month/whatever.
>  > 
>  > I'll hack something up.
> 
> Nightly snapshots will appear here..
> http://www.codemonkey.org.uk/projects/pci/
> 
> I've thought again on the regular sending.. as they can be
> quite large diffs occasionally, it's probably better if
> gregkh pulls this into his pci tree every so often,
> that way it goes into mainline semi-automatically, and
> also gets some visibility in -mm for a while.
> 
> How's that sound Greg? Or would you prefer I dump
> this into a bk tree you can regularly pull from?
> It's only a bit more scripting to do so..

Sending me emails with the patches is fine for me.  Feel free to
automate it if you want to, that would really help out.

Do we have a way for patches to flow back into sf.net.  I remember we
had some "line too long" warnings that we had to fix up by hand in that
file that probably didn't make it upstream.

I'll go grab the latest version of the patch on your site to add to my
bk-pci tree right now...

thanks,

greg k-h
