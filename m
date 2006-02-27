Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWB0DwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWB0DwG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 22:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWB0DwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 22:52:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750782AbWB0DwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 22:52:04 -0500
Date: Sun, 26 Feb 2006 19:51:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm2 configs
Message-Id: <20060226195109.051bb53f.akpm@osdl.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30062E9D71@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30062E9D71@hdsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> wrote:
>
>  
> >> a.  why does SONY_ACPI default to m ?  Other similar options 
> >are default n.
> >
> >Because I got heartily sick of losing the setting each time I 
> >went back to a mainline kernel and did `make oldconfig'.
> 
> IIR the recommendation from Roman on these things was
> to remove the default entirely.  If you have a favorite
> .config file with =m in it, then make oldconfig should
> preserve that choice.
> 

Nope.  Once you remove the Kconfig entry entirely (ie: go back to a
mainline kernel), `make oldconfig' will rub that config entry out
completely.
