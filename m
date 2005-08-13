Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVHMWMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVHMWMT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 18:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVHMWMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 18:12:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:63939 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932351AbVHMWMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 18:12:17 -0400
Date: Sat, 13 Aug 2005 15:11:48 -0700
From: Greg KH <greg@kroah.com>
To: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
Message-ID: <20050813221148.GA20060@kroah.com>
References: <1123868902.10923.5.camel@w2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123868902.10923.5.camel@w2>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 07:48:22PM +0200, Wieland Gmeiner wrote:
> @@ -294,3 +294,4 @@ ENTRY(sys_call_table)
>  	.long sys_inotify_init
>  	.long sys_inotify_add_watch
>  	.long sys_inotify_rm_watch
> +        .long sys_getprlimit

Please follow the proper kernel coding style when writing new kernel
code...

thanks,

greg k-h
