Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUIOVkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUIOVkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUIOVhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:37:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:11444 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267599AbUIOVgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:36:42 -0400
Date: Wed, 15 Sep 2004 14:35:59 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915213559.GE25840@kroah.com>
References: <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost> <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com> <1095279043.23385.102.camel@betsy.boston.ximian.com> <20040915212110.GA25840@kroah.com> <1095283614.23385.119.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095283614.23385.119.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 05:26:54PM -0400, Robert Love wrote:
> On Wed, 2004-09-15 at 14:21 -0700, Greg KH wrote:
> 
> > Doh!  You're right.  Here's Kay's patch ported to the new interface, and
> > adding a umount event type.  I've applied it to my trees.
> 
> I am actually thinking that Kay's approach is less than ideal, since it
> does not catch all mounts and unmounts.

Ok, well if you two agree that something else should be done, send me a
patch against this last one :)

thanks,

greg k-h
