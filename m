Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSKUDO7>; Wed, 20 Nov 2002 22:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSKUDO6>; Wed, 20 Nov 2002 22:14:58 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:19937 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266318AbSKUDO4>;
	Wed, 20 Nov 2002 22:14:56 -0500
Date: Thu, 21 Nov 2002 14:21:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <willy@debian.org>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] rename get_lease to break_lease
Message-Id: <20021121142139.75c0f19e.sfr@canb.auug.org.au>
In-Reply-To: <20021120064831.A12656@parcelfarce.linux.theplanet.co.uk>
References: <20021120064831.A12656@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Wed, 20 Nov 2002 06:48:31 +0000 Matthew Wilcox <willy@debian.org> wrote:
>
> (b) fixes a bug noticed by Dave Hansen which could cause a NULL pointer
> dereference under high load.

Thanks for this, I forgot that I hadn't forward ported this fix from 2.4.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
