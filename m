Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUHEOoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUHEOoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267723AbUHEOmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:42:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:51919 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267722AbUHEOje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:39:34 -0400
Date: Thu, 5 Aug 2004 16:39:33 +0200
From: Olaf Hering <olh@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, spot@redhat.com, akpm@osdl.org
Subject: Re: Make MAX_INIT_ARGS 25
Message-ID: <20040805143933.GA19219@suse.de>
References: <20040804193243.36009baa@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040804193243.36009baa@lembas.zaitcev.lan>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Aug 04, Pete Zaitcev wrote:

> 
> --- linux-2.6.7/init/main.c	2004-06-16 16:54:07.000000000 -0700
> +++ linux-2.6.7-usb/init/main.c	2004-08-04 19:16:22.566593218 -0700
> @@ -102,8 +102,8 @@
>  /*
>   * Boot command-line arguments
>   */
> -#define MAX_INIT_ARGS 8
> -#define MAX_INIT_ENVS 8
> +#define MAX_INIT_ARGS 25
> +#define MAX_INIT_ENVS 25

Why is there a limit anyway? Can the whole thing be dynamic? Any why
panic if there are more than n options passed? Just ignore the remaining
options?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
