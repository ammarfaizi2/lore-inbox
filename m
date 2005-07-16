Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVGPD7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVGPD7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVGPD7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:59:31 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:33527 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S262176AbVGPD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:59:31 -0400
Subject: Re: [PATCH] mb_cache_shrink() frees unexpected caches
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200507160344.06235.agruen@suse.de>
References: <1121346444.4282.8.camel@localhost.localdomain>
	 <200507151636.27532.agruen@suse.de>
	 <1121440067.4137.2.camel@localhost.localdomain>
	 <200507160344.06235.agruen@suse.de>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 12:53:12 +0900
Message-Id: <1121485992.22941.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005-07-16 (Sat) 03:44 +0200 Andreas Gruenbacher wrote:
> Removing the cache parameter from mb_cache_shrink would break when more than 
> one mb_cache is used per filesystem, correct. Leaving the parameter in and 
> adding your patch is more "future proof", so I'm fine with it. Are you 
> actually using more than one mb_cache, or is this theoretical?

This is just theorecal.

Now I agree with your two patches except for the name of
"mb_cache_shrink".  it should be renamed to imply that this function
shrinks all sort of mbcache on specified block device.





