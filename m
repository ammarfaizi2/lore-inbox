Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131163AbQLMWmp>; Wed, 13 Dec 2000 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbQLMWmg>; Wed, 13 Dec 2000 17:42:36 -0500
Received: from Cantor.suse.de ([194.112.123.193]:35338 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131163AbQLMWmY>;
	Wed, 13 Dec 2000 17:42:24 -0500
Date: Wed, 13 Dec 2000 23:11:55 +0100
From: Andi Kleen <ak@suse.de>
To: Tim Waugh <twaugh@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] 2.4.0-test12:
Message-ID: <20001213231155.A2690@gruyere.muc.suse.de>
In-Reply-To: <20001213192352.L5918@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001213192352.L5918@redhat.com>; from twaugh@redhat.com on Wed, Dec 13, 2000 at 07:23:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 07:23:52PM +0000, Tim Waugh wrote:
> + * atomic_add - add integer to atomic variable
> + * @i: integer value to add
> + * @v: pointer of type atomic_t
> + * 
> + * Atomically adds @i to @v.

Perhaps it should mention that the guaranteed useful range of atomic_t 
is only 24bit ?  Documentation without source would rather useless if it
didn't mention such pitfalls.


-Andi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
