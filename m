Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUFNVl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUFNVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUFNVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:41:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:56528 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264503AbUFNVlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:41:51 -0400
Date: Mon, 14 Jun 2004 14:40:17 -0700
From: Greg KH <greg@kroah.com>
To: Tobias Weisserth <tobias@weisserth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux 2.6.4] EagleTec (rev 1.13) USB external harddisk support -> patch to unusual_devs.h
Message-ID: <20040614214017.GB3688@kroah.com>
References: <1086086759.10599.14.camel@coruscant.weisserth.net> <20040602165723.GI7829@kroah.com> <1086200163.8709.8.camel@coruscant.weisserth.net> <20040602182131.GA13193@kroah.com> <1086207977.8707.38.camel@coruscant.weisserth.net> <20040602203307.GA19749@kroah.com> <1086213609.8710.79.camel@coruscant.weisserth.net> <20040602225906.GA23819@kroah.com> <1086455663.7588.6.camel@coruscant.weisserth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086455663.7588.6.camel@coruscant.weisserth.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 07:14:23PM +0200, Tobias Weisserth wrote:
> Hi,
> 
> On Thu, 2004-06-03 at 00:59, Greg KH wrote:
> ...
> > Nope, sorry.  Don't cut and paste.  Try attaching as a text attachment,
> > or doing something with your editor to read from your patch file into
> > the body of the email.
> 
> I tried the latter. Doesn't seem to work.
> 
> I attached the patches.
> 
> Those are a patch for the 2.6.6 kernel and the 2.6.4 kernel.
> 
> When I was going through all my kernel branches in /usr/src I noticed
> that the Gentoo development branch already had a suitable entry for the
> firmware version of my device:
> 
> /* Reported by Henning Schild <henning@wh9.tu-dresden.de> */
> UNUSUAL_DEV(  0x05e3, 0x0702, 0x0113, 0x0113,
>                 "EagleTec",
>                 "External Hard Disk",
>                 US_SC_DEVICE, US_PR_DEVICE, NULL,
>                 US_FL_FIX_INQUIRY ),
> 
> More information on these sources:
> 
> http://packages.gentoo.org/ebuilds/?gentoo-dev-sources-2.6.5-r1
> 
> I found it in no other branch besides this.
> 
> So if you include my patch then you might consider putting his name
> there too. I discovered his entry after I figured out by myself how to
> make EagleTec revision 1.13 work, but I don't know whether he did it
> before me.

Hm, this is already fixed in the current kernel trees, so your patch
should not be needed.

thanks,

greg k-h
