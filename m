Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVEKSax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVEKSax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEKSax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:30:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:5348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261258AbVEKSaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:30:46 -0400
Date: Wed, 11 May 2005 11:30:46 -0700
From: Greg KH <gregkh@suse.de>
Cc: security@isec.pl, linux-kernel@vger.kernel.org,
       full-disclosure@lists.netsys.com, bugtraq@securityfocus.com,
       vulnwatch@vulnwatch.org
Subject: Re: Linux kernel ELF core dump privilege elevation
Message-ID: <20050511183046.GA17112@kroah.com>
References: <Pine.LNX.4.44.0505101615410.1618-100000@isec.pl> <20050511181211.GA16652@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511181211.GA16652@kroah.com>
User-Agent: Mutt/1.5.8i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 11:12:11AM -0700, Greg KH wrote:
> On Wed, May 11, 2005 at 01:08:56PM +0200, Paul Starzetz wrote:
> > Hi,
> > 
> > since it became clear from the discussion in January about the uselib() 
> > vulnerability, that the Linux community prefers full, non-embargoed 
> > disclosure of kernel bugs, I release full details right now. However to 
> > follows at least some of the responsable disclosure rules, no exploit code will be 
> > released. Instead, only a proof-of-concept code is released to demonstrate 
> > the vulnerability.
> 
> <snip>
> 
> And here's a patch for 2.6 that is completly untested.  I'll work on
> testing it today and if it works, we will release a new 2.6.11.y release
> with this fix in it.
> 
> thanks,
> 
> greg k-h
> 
> 
> Subject: possibly fix Linux kernel ELF core dump privilege elevation
> 
> As noted by Paul Starzetz
> 
> references CAN-something-I-need-to-go-look-up...

CAN-2005-1263  is the correct one.  Sorry for being lazy and not looking
it up right away.

thanks,

greg k-h
