Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbQKRMMN>; Sat, 18 Nov 2000 07:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbQKRMME>; Sat, 18 Nov 2000 07:12:04 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:31759 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129352AbQKRML4>;
	Sat, 18 Nov 2000 07:11:56 -0500
Date: Sat, 18 Nov 2000 12:35:36 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: mingo@redhat.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raid5 fix after xor.c cleanup
Message-ID: <20001118123536.A5674@spaans.ds9a.nl>
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl>; from jasper@spaans.ds9a.nl on Fri, Nov 17, 2000 at 11:41:44PM +0100
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 11:41:44PM +0100, Jasper Spaans wrote:

> due to the xor.c cleanup in 2.4.0-test11-pre5+, raid5 compiled into the
> kernel fails when booting, because the calibrate_xor_block function
> hasn't been called while registering a raid5 volume; this leads to a
> panic, as no checksumming function has been chosen.
> 
> Here's a tiny patch to restore that functionality, can you apply it?

Hmm, next time I'll need to eat my own dogfood -- this patch doesn't work, it
only compiles. Don't use it.

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
