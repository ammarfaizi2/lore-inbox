Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVJMXzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVJMXzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVJMXzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:55:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:33188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751122AbVJMXzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:55:13 -0400
Date: Thu, 13 Oct 2005 16:53:58 -0700
From: Greg KH <gregkh@suse.de>
To: "Mathieu Therrien, VE2TMQ" <ve2tmq@rac.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Patch: Remove devfs from 2.6.13
Message-ID: <20051013235358.GA4443@suse.de>
References: <434E9D48.70306@rac.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434E9D48.70306@rac.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 01:45:44PM -0400, Mathieu Therrien, VE2TMQ wrote:
> Hello every one!&nbsp; I read this document : <a
> class="moz-txt-link-freetext"
> href="http://lwn.net/Articles/151174/">http://lwn.net/Articles/151174/</a><br>
> but I don't understand the reason to remove devfs from the kernel
> selection.&nbsp;

Please search the archives for the reasons why.  In short:
	- It had unfixable bugs.
	- It was unmaintained for many years.
	- It has been marked OBSOLETE for about 1 1/2 years
	- It has been documented that it would be removed for over a
	  year.
	- It puts naming policy into the kernel, where it is not needed.
	- It is not LSB compliant.
	- there are numerous userspace solutions that do the same thing,
	  in much better ways.

thanks,

greg k-h
