Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132006AbRAQKCi>; Wed, 17 Jan 2001 05:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132124AbRAQKC2>; Wed, 17 Jan 2001 05:02:28 -0500
Received: from [172.16.18.67] ([172.16.18.67]:43907 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132006AbRAQKCT>; Wed, 17 Jan 2001 05:02:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A656C09.4A40BBF5@mandrakesoft.com> 
In-Reply-To: <3A656C09.4A40BBF5@mandrakesoft.com>  <200101162111.f0GLBNb14141@webber.adilger.net> <20276.979724327@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jan 2001 10:02:07 +0000
Message-ID: <13466.979725727@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  The one thing I don't know is... can the kernel mount the root fs if
> only given the uuid?

There are 2.2 patches to do it, which I think are now being dusted off and 
resurrected. but scanning for UUID involves poking at every partition on 
every available hard drive.

Doing it by serial number (do SCSI drives have a unique serial number?) 
would be possible without doing that.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
