Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTIPX5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbTIPX5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:57:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:8920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262544AbTIPX5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:57:09 -0400
Date: Tue, 16 Sep 2003 16:57:30 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions
Message-ID: <20030916235729.GA6198@kroah.com>
References: <20030916181802.6046.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916181802.6046.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 12:18:02PM -0600, Jonathan Corbet wrote:
> Nobody told me that the failure to export these (like their block
> counterparts) was anything but an oversight; modules will not be able to
> use larger device numbers without them.  So...this patch exports the new
> char device functions.

How about just exporting them in the files where they are declared?  I
do not think we want the ksyms.c file to grow anymore.

thanks,

greg k-h
