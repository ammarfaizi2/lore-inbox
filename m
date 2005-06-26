Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVFZXCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVFZXCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVFZXCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:02:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17869 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261638AbVFZXA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:00:28 -0400
Message-ID: <42BF337D.1050904@pobox.com>
Date: Sun, 26 Jun 2005 19:00:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: bunk@stusta.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.6 patch] drivers/net/hamradio/: cleanups
References: <20050502014637.GQ3592@stusta.de>	<42BF2BA9.8060502@pobox.com> <20050626155318.7f065d5b.rdunlap@xenotime.net>
In-Reply-To: <20050626155318.7f065d5b.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> On Sun, 26 Jun 2005 18:26:49 -0400 Jeff Garzik wrote:
> 
> | Adrian Bunk wrote:
> | > This patch contains the following cleanups:
> | > - dmascc.c: remove the unused global function dmascc_setup
> | 
> | Better to use it, then remove it.
> 
>                     than ??

Yes.  Use it via __setup() or similar.

	Jeff



