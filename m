Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946684AbWJSXxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946684AbWJSXxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946685AbWJSXxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:53:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:3507 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946684AbWJSXxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:53:17 -0400
Date: Thu, 19 Oct 2006 16:51:49 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@MIT.EDU>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device [version 3]
Message-ID: <20061019235149.GA5343@kroah.com>
References: <20061017145146.GJ22289@parisc-linux.org> <20061019154128.GD2602@parisc-linux.org> <1161299636.16080.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161299636.16080.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 07:13:56PM -0400, Adam Belay wrote:
> It would be nice if we had sysfs expose struct file at some point... :)

No it would not.  I have yet to see a valid reason why to do this
(everyone would be abusing sysfs even worse if it was present, you
should see some of the requests I've had over the years...)

thanks,

greg k-h
