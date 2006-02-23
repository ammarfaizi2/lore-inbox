Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWBWOUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWBWOUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWBWOUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:20:06 -0500
Received: from webapps.arcom.com ([194.200.159.168]:23309 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751157AbWBWOUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:20:05 -0500
Message-ID: <43FDC48B.3080000@cantab.net>
Date: Thu, 23 Feb 2006 14:19:55 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] flags parameter for linkat
References: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com>
In-Reply-To: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2006 14:20:16.0421 (UTC) FILETIME=[4496CD50:01C63884]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> 
> --- ./arch/s390/kernel/compat_wrapper.S-new	2006-02-23 06:00:12.000000000 -0800
> +++ ./arch/s390/kernel/compat_wrapper.S	2006-02-23 05:51:32.000000000 -0800
> @@ -1552,7 +1552,6 @@
>  	llgtr	%r3,%r3			# const char *
>  	lgfr	%r4,%r4			# int
>  	llgtr	%r5,%r5			# const char *
> -	lgfr	%r6,%r6			# int
>  	jg	sys_linkat

This hunk appears to be reversed.

David Vrabel
