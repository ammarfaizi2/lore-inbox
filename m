Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbTLFBkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbTLFBkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:40:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:42977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264911AbTLFBkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:40:01 -0500
Date: Fri, 5 Dec 2003 17:03:13 -0800
From: Greg KH <greg@kroah.com>
To: Bernard Collins <bernard.collins@jhuapl.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Visor USB hang
Message-ID: <20031206010312.GD14819@kroah.com>
References: <E37E01957949D611A4C30008C7E691E20915BBFC@aples3.dom1.jhuapl.edu> <20031204002414.GI21541@kroah.com> <1070549371.26393.6.camel@collibf1.jhuapl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070549371.26393.6.camel@collibf1.jhuapl.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 09:49:31AM -0500, Bernard Collins wrote:
> On Wed, 2003-12-03 at 19:24, Greg KH wrote:
> > 	rmmod usb-uhci && modprobe uhci
> 
> OK, this works. The Visor now hotsyncs and I get no hangs or freezes.
> Thanks. I am still willing to help track down the problem if you have
> any other diagnostic suggestions.

Sounds like a uhci timing issue :(

> So is there a downside to uhci compared to usb-uhci?

Not that I know of, it's what I use...

> Would moving to kernel 2.6 likely fix the problem? 

Hopefully, but there's a current nasty 2.6.0-test11 oops with usb-serial
devices right now that you might want to hold off for a few days...

> Finally, what is the "right way" to get my redhat system to
> permanently use uhci?

edit your modules.conf file?

greg k-h
