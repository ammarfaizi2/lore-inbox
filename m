Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTLGD0b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 22:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbTLGD0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 22:26:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:35270 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265295AbTLGD03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 22:26:29 -0500
Date: Sat, 6 Dec 2003 19:22:52 -0800
From: Greg KH <greg@kroah.com>
To: "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
Cc: "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>
Subject: Re: Visor USB hang
Message-ID: <20031207032251.GA28879@kroah.com>
References: <E37E01957949D611A4C30008C7E691E2F38C26@aples3.dom1.jhuapl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E37E01957949D611A4C30008C7E691E2F38C26@aples3.dom1.jhuapl.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 12:52:52PM -0500, Collins, Bernard F. (Skip) wrote:
>  
> Greg KH wrote:
> >On Thu, Dec 04, 2003 at 09:49:31AM -0500, Bernard Collins wrote:
> > On Wed, 2003-12-03 at 19:24, Greg KH wrote:
> 
> > Sounds like a uhci timing issue :(
> 
> Does :( mean that it is not likely to be fixed? If so, is that because
> usb-uhci is going to be deprecated in favor of uhci?

Well, in 2.6, uhci turned into uhci-hcd and the usb-uhci driver
disappeared.

> >> So is there a downside to uhci compared to usb-uhci?
> 
> > Not that I know of, it's what I use...
> 
> I did find one problem on my machine: VMware USB support depends on
> usb-uhci. Oh, and my USB storage keychain device works with usb-uhci but not
> uhci.

I've run vmware just fine with uhci, it just seems that some distros
prefer usb-uhci.  But use what works for you.

greg k-h
