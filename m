Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUAZBUo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUAZBUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:20:44 -0500
Received: from c-24-19-67-22.client.comcast.net ([24.19.67.22]:34432 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S265346AbUAZBUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:20:43 -0500
Message-ID: <40146B68.6070007@comcast.net>
Date: Sun, 25 Jan 2004 17:20:40 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jik@kamens.brookline.ma.us
Subject: Re: MD Oops on boot with 2.6.2-rc1-mm3
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There appears to be a dud raid patch in -mm.  It'll be one of the md-*
> patches.
> 
> If you have time, could you work out which one?  Ones to start with might be
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/ \
> broken-out/md-02-preferred_minor-fix.patch
> 
> and
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/ \
> broken-out/md-06-allow-partitioning.patch
> 
> 

I had a repeatable oops that sounds identical to what Jonathan
originally reported. Backing out md-06-allow-partitioning.patch fixed
the oops at boot for me. Thanks,

-Walt


