Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTFPGee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 02:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFPGee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 02:34:34 -0400
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:54487 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S262174AbTFPGed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 02:34:33 -0400
Message-ID: <3EED6885.2090206@sixbit.org>
Date: Mon, 16 Jun 2003 02:49:41 -0400
From: John Weber <weber@sixbit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: John Weber <weber@sixbit.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [linux 2.5.71] Unresolved symbol malloc_sizes
References: <20030615012007$335e@gated-at.bofh.it>
In-Reply-To: <20030615012007$335e@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:
> I get warnings that __kmalloc and malloc_sizes are undefined in all the 
> drivers that I build as modules in 2.5.71.  This is not solely a matter 
> of including slab.h either.  The orinoco_cs driver, for example, 
> includes slab.h and I still get this error.  Any pointers?

I decided to do a build from a new linux-2.5.71 tree and this problem 
went away.  I guess something strange happened to my source tree in one 
of those daily (bk<->)cvs updates.


