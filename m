Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTIQRZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 13:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbTIQRZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 13:25:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:47292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262598AbTIQRZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 13:25:07 -0400
Date: Wed, 17 Sep 2003 10:22:49 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions
Message-ID: <20030917172249.GA4384@kroah.com>
References: <20030916235729.GA6198@kroah.com> <20030917023630.24595.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917023630.24595.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 08:36:30PM -0600, Jonathan Corbet wrote:
> > How about just exporting them in the files where they are declared?  I
> > do not think we want the ksyms.c file to grow anymore.
> 
> Hmm, I figured somebody would say something like that...grumble...mutter...
> ...complain...gripe...moan...new patch appended...
> 
> Of course, there are other exports from that file (i.e. register_chrdev());
> are we actively trying to shrink ksyms.c?

I just think we aren't trying to grow it at this time :)

thanks,

greg k-h
