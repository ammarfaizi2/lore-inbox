Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVIIWhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVIIWhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVIIWhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:37:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932609AbVIIWhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:37:37 -0400
Date: Fri, 9 Sep 2005 15:37:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <20050909220758.GA29746@kroah.com>
Message-ID: <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
References: <20050909220758.GA29746@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Sep 2005, Greg KH wrote:
> 
> Dave Jones:
>   must_check attributes for PCI layer.

Why?

This only clutters up the compile, hiding real errors.

I think all those compile warnings are totally bogus. Who really cares? 
Are they going to be fixed, or were they added just to irritate people?

We should have a strict rule: anybody who adds things like "must_check"
and "deprecated" had better also be ready and willing to fix all the new
warnings they cause - you're not allowed to just assume that "somebody
else will fix it".

		Linus
