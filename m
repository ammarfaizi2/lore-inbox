Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291741AbSBTKff>; Wed, 20 Feb 2002 05:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291738AbSBTKfZ>; Wed, 20 Feb 2002 05:35:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28434 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291751AbSBTKfG>;
	Wed, 20 Feb 2002 05:35:06 -0500
Date: Wed, 20 Feb 2002 11:29:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@ucw.cz>, trivial@rustcorp.com.au,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Tiny IDE cleanup
Message-ID: <20020220102915.GC8675@suse.de>
In-Reply-To: <20020219194155.GA5468@elf.ucw.cz> <3C737A2C.2060305@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C737A2C.2060305@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20 2002, Martin Dalecki wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >What about this tiny cleanup? Its against 2.4., but applicable to 2.5,
> >too.
> >
> 
> That's file.
> 
> If you dare to have a look at the LOCAL_END_REQUEST macro
> as well? It's only used by IDE and NBD code.
> I think that from IDE it can be just deleted. But I didn't
> look at NBD.

LOCAL_END_REQUEST is safe to kill, please go ahead.

-- 
Jens Axboe

