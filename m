Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269620AbUJLLY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269620AbUJLLY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269618AbUJLLY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:24:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:24541 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269620AbUJLLYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:24:18 -0400
Date: Tue, 12 Oct 2004 13:24:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] transmeta efficeon support and cpuid update
In-Reply-To: <Pine.LNX.4.61.0410111941570.16060@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.61.0410121322280.7182@scrub.home>
References: <Pine.LNX.4.61.0410111916300.16060@twinlark.arctic.org>
 <Pine.LNX.4.61.0410111941570.16060@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 11 Oct 2004, dean gaudet wrote:

>  config X86_TSC
>  	bool
> -	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
> +	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
>  	default y

BTW Kconfig supports breaking long lines using '\'.

bye, Roman
