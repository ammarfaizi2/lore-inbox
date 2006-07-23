Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWGWW6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWGWW6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 18:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWGWW6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 18:58:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40167 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751363AbWGWW6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 18:58:05 -0400
Date: Mon, 24 Jul 2006 08:57:01 +1000
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       James Morris <jmorris@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: include/linux/xattr.h: how much userpace visible?
Message-ID: <20060724085701.B2083275@wobbly.melbourne.sgi.com>
References: <20060723184343.GA25367@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060723184343.GA25367@stusta.de>; from bunk@stusta.de on Sun, Jul 23, 2006 at 08:43:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2006 at 08:43:43PM +0200, Adrian Bunk wrote:
> Hi,
> 
> how much of include/linux/xattr.h has to be part of the userspace kernel 
> headers?

None, I think.

> The function prototypes should no longer be visible in userspace.
> But how much of the rest of this file is usable for userspace?

The attr package has its own distinct copy of this file, which has
no kernel pieces - I'm not sure whether libc ended up copying this
or doing its own thing though.

cheers.

-- 
Nathan
