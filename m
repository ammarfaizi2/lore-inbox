Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWFTQIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWFTQIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWFTQIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:08:36 -0400
Received: from xenotime.net ([66.160.160.81]:27831 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750847AbWFTQIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:08:36 -0400
Date: Tue, 20 Jun 2006 09:11:16 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jes Sorensen <jes@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec
Message-Id: <20060620091116.e81d4360.rdunlap@xenotime.net>
In-Reply-To: <yq0hd2gyvl7.fsf@jaguar.mkp.net>
References: <yq0lkrtzelk.fsf@jaguar.mkp.net>
	<20060619085855.277cd217.rdunlap@xenotime.net>
	<yq0hd2gyvl7.fsf@jaguar.mkp.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 2006 06:23:16 -0400 Jes Sorensen wrote:

> >>>>> "Randy" == Randy Dunlap <rdunlap@xenotime.net> writes:
> 
> Randy> On 19 Jun 2006 05:20:23 -0400 Jes Sorensen wrote:
> >> +MODULE_AUTHOR("Silicon Graphics, Inc.");
> >> +MODULE_DESCRIPTION("Driver for SGI SN special memory operations");
> >> +MODULE_LICENSE("GPL"); +MODULE_INFO(supported, "external");
> 
> Randy> What does that last line mean?  what does "external" mean?
> Randy> There are no other source files in the 2.6.17 tree that say
> Randy> anything like that.
> 
> Randy> And of the 1800+ MODULE_AUTHOR() lines, SGI seems to be
> Randy> dominant is using company instead of a person for AUTHOR.  Yes,
> Randy> there are a few others as well.  module.h says: /* Author,
> Randy> ideally of form NAME <EMAIL>[, NAME <EMAIL>]*[ and NAME
> Randy> <EMAIL>] */
> 
> Randy,
> 
> I went back and looked through the usages of these macros and it does
> indeed seem that nobody else tries to state 'supported' in MODULE_INFO
> so I have removed that and added an email address to the author line,
> which should always stay valid.

Hi Jes,
Thanks for doing that, esp. the 'supported' part.


> +MODULE_AUTHOR("Silicon Graphics, Inc. <linux-altix@sgi.com>");
> +MODULE_DESCRIPTION("Driver for SGI SN special memory operations");
> +MODULE_LICENSE("GPL");

---
~Randy
