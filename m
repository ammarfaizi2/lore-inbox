Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTEFDpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTEFDpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:45:47 -0400
Received: from granite.he.net ([216.218.226.66]:55813 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262306AbTEFDpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:45:45 -0400
Date: Mon, 5 May 2003 21:00:04 -0700
From: Greg KH <greg@kroah.com>
To: Michael Swift <mikesw@cs.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Buggy drivers/modules needed
Message-ID: <20030506040004.GB5403@kroah.com>
References: <2B0E86920B2B9C43A043DA80E447FCBC7BB895@exchsrv1.cseresearch.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2B0E86920B2B9C43A043DA80E447FCBC7BB895@exchsrv1.cseresearch.cs.washington.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:36:32PM -0700, Michael Swift wrote:
> 
> What I would like is either:
> 
> a) sound card, network interface, or file system code with bugs that
> cause an oops. In particular, a pointer to what piece of code causes
> the oops would be helpful.

rmmod a usb host controller driver in the 2.5.69 kernel tree.  That will
cause major problems that would be nice to see if you can recover from :)

Good luck,

greg k-h
