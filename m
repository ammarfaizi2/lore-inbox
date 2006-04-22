Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWDVWEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWDVWEO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 18:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWDVWEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 18:04:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:19150 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751247AbWDVWEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 18:04:13 -0400
Date: Sat, 22 Apr 2006 14:36:02 -0700
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: chrisw@sous-sol.org, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the Root Plug Support sample module
Message-ID: <20060422213602.GA25500@suse.de>
References: <20060421201943.GJ19754@stusta.de> <20060421202918.GB32119@suse.de> <20060422085737.GL19754@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422085737.GL19754@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 10:57:37AM +0200, Adrian Bunk wrote:
> On Fri, Apr 21, 2006 at 01:29:18PM -0700, Greg KH wrote:
> >...
> > So, I'd like to keep this in the tree, for as long as the LSM interface
> > sticks around, if possible.  It's not hurting anything, and it does work
> > for users, and is a good example starting point for people wanting to
> > use the LSM interface.
> > 
> > Unless there are any known security problems with it?  If so, please let
> > me know.
> 
> Using USB Vendor ID/USB Product ID for identifying an USB device doesn't 
> seem to bring real security since:
> - every other device of the same type works as well
> - using an arbitrary USB device with a manipulated
>   USB Vendor ID/USB Product ID seems quite possible
> 
> It might work as an example, but if people think it would bring them 
> real security that's a dangerous misunderstanding.

What it gives people is a level of security for users that do not have
physical access to the machine.  If you have access to it, yes, of
course you can plug your own device in with the needed ids.

So, I'd still like to keep it around, unless LSM itself goes away.

thanks,

greg k-h
