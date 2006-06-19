Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWFSP4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWFSP4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFSP4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:56:10 -0400
Received: from xenotime.net ([66.160.160.81]:12442 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932178AbWFSP4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:56:09 -0400
Date: Mon, 19 Jun 2006 08:58:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jes Sorensen <jes@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       hugh@veritas.com, cotte@de.ibm.com, bjorn_helgaas@hp.com
Subject: Re: [patch] mspec
Message-Id: <20060619085855.277cd217.rdunlap@xenotime.net>
In-Reply-To: <yq0lkrtzelk.fsf@jaguar.mkp.net>
References: <yq0lkrtzelk.fsf@jaguar.mkp.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 2006 05:20:23 -0400 Jes Sorensen wrote:

> Hi,
> 
> Since today is the day of do_no_pfn, it is obviously also the time for
> mspec! Here we go :)

Just minor stuff:

> +MODULE_AUTHOR("Silicon Graphics, Inc.");
> +MODULE_DESCRIPTION("Driver for SGI SN special memory operations");
> +MODULE_LICENSE("GPL");
> +MODULE_INFO(supported, "external");

What does that last line mean?  what does "external" mean?
There are no other source files in the 2.6.17 tree that say
anything like that.

And of the 1800+ MODULE_AUTHOR() lines, SGI seems to be
dominant is using company instead of a person for AUTHOR.
Yes, there are a few others as well.
module.h says:
/* Author, ideally of form NAME <EMAIL>[, NAME <EMAIL>]*[ and NAME <EMAIL>] */

---
~Randy
