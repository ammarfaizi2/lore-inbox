Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWHWWFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWHWWFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWHWWFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:05:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:12761 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965100AbWHWWFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:05:08 -0400
Subject: Re: [Devel] [PATCH 1/6] BC: kconfig
From: Dave Hansen <haveblue@us.ibm.com>
To: devel@openvz.org
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rohit Seth <rohitseth@google.com>, Matt Helsley <matthltc@us.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <44EC35A3.7070308@sw.ru>
References: <44EC31FB.2050002@sw.ru>  <44EC35A3.7070308@sw.ru>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:04:58 -0700
Message-Id: <1156370698.12011.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 15:01 +0400, Kirill Korotaev wrote:
> --- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
> +++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
> @@ -432,3 +432,5 @@ source "security/Kconfig"
>  source "crypto/Kconfig"
>  
>  source "lib/Kconfig"
> +
> +source "kernel/bc/Kconfig"
...
> --- ./arch/sparc64/Kconfig.arkcfg	2006-07-17 17:01:11.000000000 +0400
> +++ ./arch/sparc64/Kconfig	2006-08-10 17:56:36.000000000 +0400
> @@ -432,3 +432,5 @@ source "security/Kconfig"
>  source "crypto/Kconfig"
>  
>  source "lib/Kconfig"
> +
> +source "kernel/bc/Kconfig"

Is it just me, or do these patches look a little funky?  Looks like it
is trying to patch the same thing into the same file, twice.  Also, the
patches look to be -p0 instead of -p1.  

I'm having a few problems applying them.

-- Dave

