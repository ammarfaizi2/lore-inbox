Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbRBFRz0>; Tue, 6 Feb 2001 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRBFRzQ>; Tue, 6 Feb 2001 12:55:16 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:10625 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129177AbRBFRzI>; Tue, 6 Feb 2001 12:55:08 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010206173437.A19836@redhat.com> 
In-Reply-To: <20010206173437.A19836@redhat.com>  <200102061424.PAA32284@hell.wii.ericsson.net> <E14Q9U2-0005gX-00@the-village.bc.nu> 
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anders Eriksson <aer-list@mailandnews.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sync & asyck i/o 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 17:54:41 +0000
Message-ID: <19450.981482081@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sct@redhat.com said:
>  Linux will obey that if it possibly can: only in cases where the
> hardware is actively lying about when the data has hit disk will the
> guarantee break down. 

Do we attempt to ask SCSI disks nicely to flush their write caches in this 
situation? cf. http://www.danbbs.dk/~dino/SCSI/SCSI2-09.html#9.2.18

Or do we instruct all SCSI disks not to do write caching in the first place?

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
