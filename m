Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKHOOT>; Wed, 8 Nov 2000 09:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKHOOJ>; Wed, 8 Nov 2000 09:14:09 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:45830 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129147AbQKHOOD>; Wed, 8 Nov 2000 09:14:03 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Catalin BOIE <util@deuroconsult.ro>
cc: linux-kernel@vger.kernel.org
Message-ID: <CA256991.004E2B59.00@d73mta05.au.ibm.com>
Date: Wed, 8 Nov 2000 19:37:52 +0530
Subject: Re: Userland -> Kernel communication
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I wish to give me some pointers to how to communicate with a kernel module
>from userland.
>May I use sockets?

You can use copy_to/from_user functions present in kernel space, provided
you have valid userland pointers
also put_user/get_user for single datum transfer.

regards
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
