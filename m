Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVCSRER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVCSRER (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVCSRER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:04:17 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:914 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261580AbVCSREN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:04:13 -0500
Date: Sat, 19 Mar 2005 18:02:36 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Cameron Harris <thecwin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic - r8169 on 2.6.11-rc1-mm1
Message-ID: <20050319170236.GA5923@electric-eye.fr.zoreil.com>
References: <b6d0f5fb050319074718fc7efb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d0f5fb050319074718fc7efb@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cameron Harris <thecwin@gmail.com> :
[r8169 crash]
> Linux laptop 2.6.11-rc1-mm1 #2 SMP Sun Jan 16 22:36:26 GMT 2005 i686
               ^^^^^^^^^^^^^^
[...]
> I would try a newer kernel, but the command line options for
> specifying the framebuffer settings seems to have changed in the
> latest kernel and i haven't had enough time to work out how to specify
> it.

If you can not upgrade the kernel, I can not do anything for you since
several fixes went in after 2.6.11-rc1-mm1.

Regarding your r8169 issue, I suggest:
1) download linux kernel 2.6.12-rc1
2) apply on top of it:
   http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.11/r8169/patches/r8169-570.patch
3) avoid the proprietary tainting module

Please Cc: netdev@oss.sgi.com for issues related to network drivers.

--
Ueimor
