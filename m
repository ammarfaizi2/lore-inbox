Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWIUVee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWIUVee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWIUVed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:34:33 -0400
Received: from xenotime.net ([66.160.160.81]:29888 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750886AbWIUVec convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:34:32 -0400
Date: Thu, 21 Sep 2006 14:35:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Diego Calleja <diegocg@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, jeff@garzik.org, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060921143534.c1a86dfc.rdunlap@xenotime.net>
In-Reply-To: <20060921223710.d7472801.diegocg@gmail.com>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<45121382.1090403@garzik.org>
	<20060920220744.0427539d.akpm@osdl.org>
	<1158830206.11109.84.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609210819170.4388@g5.osdl.org>
	<20060921105959.a55efb5f.akpm@osdl.org>
	<Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	<4512DB05.2090604@garzik.org>
	<20060921194604.GQ31906@stusta.de>
	<20060921223710.d7472801.diegocg@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 22:37:10 +0200 Diego Calleja wrote:

> El Thu, 21 Sep 2006 21:46:04 +0200,
> Adrian Bunk <bunk@stusta.de> escribió:
> 
> > Even the kernel Bugzilla that contains only a small subset of all bug 
> > reports contains 78 (sic) open bugs reported against 2.6.18-rc kernels [1].
> 
> I suspect that not many people is subscribed to the bugzilla mailing list,
> not surprising since the URLs doesn't seem to be in the tree :)
> 
> After fixing my english, I wonder if the following patch could be applied...
> 
> Signed-off-by: Diego Calleja <diegocg@gmail.com>
> 
> --- 2.6/Documentation/HOWTO.OLD	2006-09-21 22:14:06.000000000 +0200
> +++ 2.6/Documentation/HOWTO	2006-09-21 22:36:17.000000000 +0200
> @@ -374,6 +374,26 @@ of information is needed by the kernel d
>  problem.
>  
>  
> +Managing bug reports
> +--------------------
> +
> +One of the best ways to put into practice your hacking skills is by fixing 
> +bugs reported by other people. Not only you will help to make the kernel
> +more stable, you'll learn to fix real world problems and you will improve
> +your skills, and other developers will be aware of your presence. Fixing
> +bugs is one of the best ways to get merits between other developers, because

s/between/among/  :)

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

> +not many people like wasting time fixing other people's bugs.
> +
> +To work in the already reported bug reports, go to http://bugzilla.kernel.org.
> +If you want to be advised of the future bug reports, you can subscribe to the
> +bugme-new mailing list (only new bug reports are mailed here) or to the
> +bugme-janitor mailing list (every change in the bugzilla is mailed here)
> +
> +	http://lists.osdl.org/mailman/listinfo/bugme-new
> +	http://lists.osdl.org/mailman/listinfo/bugme-janitors
> +
> +
> +
>  Mailing lists
>  -------------
>  
> -

---
~Randy
