Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263145AbVGNUJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbVGNUJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVGNUGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:06:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:29918 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263142AbVGNUES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:04:18 -0400
Date: Thu, 14 Jul 2005 22:00:42 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Greg KH <greg@kroah.com>
Cc: Adam Belay <abelay@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] split PCI probing code [1/9]
Message-ID: <20050714200042.GB16069@electric-eye.fr.zoreil.com>
References: <1121331304.3398.89.camel@localhost.localdomain> <20050714171014.GA16069@electric-eye.fr.zoreil.com> <20050714193049.GA31595@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714193049.GA31595@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> :
> On Thu, Jul 14, 2005 at 07:10:14PM +0200, Francois Romieu wrote:
> > Adam Belay <abelay@novell.com> :
> > [...]
> > 
> > Some nits + a suspect error branch. It seems nice otherwise.
> 
> If I'm correct, this patch only moves the code into different files, it
> doesn't change any of it, so your comments apply to the current code
> today, not Adam's changes :)

The summary of the serie advertised cleaner code (TM). I wish I could clean
the clothes simply by moving them around.

[...]
> > mm/slab.c provides kcalloc.
> 
> Ick, I hate that function call, this is nicer :)

No problem. I just want to be sure that janitors have noticed it. O:o)

--
Ueimor
