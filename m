Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265378AbUFHXFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUFHXFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbUFHXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:05:12 -0400
Received: from gprs214-242.eurotel.cz ([160.218.214.242]:61825 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265382AbUFHXFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:05:04 -0400
Date: Wed, 9 Jun 2004 01:04:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Gross <mgross@linux.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp "not enough swap space" 2.6.5-mm6.
Message-ID: <20040608230450.GA13916@elf.ucw.cz>
References: <200406080829.35120.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406080829.35120.mgross@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm sorry for not having more information, but the failing computer is my home 
> laptop (I'll get more details after work or I'll bring it in tomorrow for 
> more details).
> 
> Anyway, this thing does software suspend using the 2.6.2-mm1 kernel, and last 
> night I was updating it to 2.6.5-mm6, and I started getting these not enough 
> disk space errors.
> 
> I found your bug fix patch, 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107806008626357&w=2
>  and checked that it is included in the 2.6.5-mm6 kernel I'm using.
> 
> Without more information does this problem ring any bells?
> 
> Can you recommend a "good" kernel version that does reliable swsusp?

Get 2.6.6, and set swappiness to 100.

								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
