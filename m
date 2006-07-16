Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946070AbWGPNKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946070AbWGPNKv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 09:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946067AbWGPNKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 09:10:51 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:45458 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1946010AbWGPNKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 09:10:50 -0400
Message-ID: <44BA3C59.9030503@gentoo.org>
Date: Sun, 16 Jul 2006 14:17:13 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/wireless/zd1211rw/: possible cleanups
References: <20060715003511.GE3633@stusta.de>
In-Reply-To: <20060715003511.GE3633@stusta.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global functions static
> - #if 0 unused functions
> 
> Please review which of these functions do make sense and which do 
> conflict with pending patches.

Thanks Adrian. I have put this in my tree and made an additional change 
along the same lines (your patched introduced an unused function warning 
to the non-debug build). If Ulrich signifies acceptance, I will send 
this on to John.

I have also sent in a patch to add a MAINTAINERS entry for zd1211rw, in 
hope that this will help you send patches with myself and/or Ulrich CC'd 
in future :)

Thanks.
Daniel
