Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUEBGVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUEBGVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUEBGVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:21:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:44429 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261472AbUEBGVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:21:42 -0400
Date: Sat, 1 May 2004 22:51:44 -0700
From: Greg KH <greg@kroah.com>
To: stefan.eletzhofer@eletztrick.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
Message-ID: <20040502055144.GE31886@kroah.com>
References: <20040429120250.GD10867@gonzo.local> <20040501054804.GH21431@kroah.com> <20040501092604.GA23561@gonzo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501092604.GA23561@gonzo.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 11:26:04AM +0200, stefan.eletzhofer@eletztrick.de wrote:
> On Fri, Apr 30, 2004 at 10:48:04PM -0700, Greg KH wrote:
> > On Thu, Apr 29, 2004 at 02:02:50PM +0200, stefan.eletzhofer@eletztrick.de wrote:
> > > +	if ( !buf || !client ) {
> > 
> > Can you clean up your exuberant use of spaces in 'if' statements, and
> > function calls?  It's not the proper kernel style.
> > 
> > > +DONE:
> > 
> > Lowercase please
> > 
> > > +	if ( ret ) {
> > > +		if ( d ) kfree( d );
> > 
> > No need to check a pointer before sending it to kfree.
> 
> Ok, that should be it. I've also ran the source through Lindent,
> which fixed some further things. I've reverted the indention change
> for labels, though. I think labels should be at level zero, should
> they?

Looks good, applied, thanks.

greg k-h
