Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKMQRy>; Mon, 13 Nov 2000 11:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129750AbQKMQRp>; Mon, 13 Nov 2000 11:17:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57094 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129069AbQKMQRc>;
	Mon, 13 Nov 2000 11:17:32 -0500
Message-ID: <3A101417.EA466EF6@mandrakesoft.com>
Date: Mon, 13 Nov 2000 11:17:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Steven_Snyder@3com.com, linux-kernel@vger.kernel.org
Subject: Re: State of Posix compliance in v2.2/v2.4 kernel?
In-Reply-To: <88256996.00577D9E.00@hqoutbound.ops.3com.com> <3A101009.5F05DA18@mandrakesoft.com> <20001113111319.E1514@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> Well, it does not do its best. There are several areas where kernel should
> help, things like POSIX semaphores would be much faster with kernel support,
> likewise threads if some things Ulrich stated here a couple of months
> ago were done in the kernel,

Would it be reasonable to have these needs documented in a central
location, with patches attached where possible?

Making people other than Linus aware of the technical issues can only
benefit the cause of POSIX compliancy, IMHO...


> POSIX message queue passing is not doable in
> userland without kernel help either (I have a message queue filesystem
> kernel patch for this, but it is a 2.5 thing).

If its small and standalone and doesn't touch existing infrastructure...

Regards,

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
