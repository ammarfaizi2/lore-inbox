Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbVIIPaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbVIIPaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVIIPaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:30:04 -0400
Received: from xenotime.net ([66.160.160.81]:8147 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751416AbVIIPaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:30:03 -0400
Date: Fri, 9 Sep 2005 08:30:01 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Lares Moreau <lares.moreau@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Debugging
In-Reply-To: <1126269625.9305.2.camel@jove>
Message-ID: <Pine.LNX.4.50.0509090826540.4978-100000@shark.he.net>
References: <1126269625.9305.2.camel@jove>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Lares Moreau wrote:

> OKay this is a noobie question,
>
> I have all the kernel debugging options turned.  Now how do I change the
> kernel logging level from prompt?  Or do I?
>
> I have 'loglevel=7' appended to my kernel line in grub.  Is that all I
> need or is there more to it?
>
> Worry not I have syslog-ng setup properly

'loglevel=7' should be sufficient, except that I have seen some
distro's init scripts change it during bootup, so just be aware
of that (or search for it).

I usually use loglevel or 8 or 9 (via alt-sysrq-N).  According to
Documentation/kernel-parameters.txt:
loglevel=	All Kernel Messages with a loglevel smaller than the
		console loglevel will be printed to the console.
so using a value of 7 would omit KERN_DEBUG messages.
		7 (KERN_DEBUG)		debug-level messages

-- 
~Randy
