Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281548AbRKMIRx>; Tue, 13 Nov 2001 03:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281550AbRKMIRm>; Tue, 13 Nov 2001 03:17:42 -0500
Received: from mail110.mail.bellsouth.net ([205.152.58.50]:18392 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281548AbRKMIRb>; Tue, 13 Nov 2001 03:17:31 -0500
Message-ID: <3BF0D706.4B20A63C@mandrakesoft.com>
Date: Tue, 13 Nov 2001 03:17:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: kaos@ocs.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
In-Reply-To: <20011112.220341.54186374.davem@redhat.com>
		<12682.1005632186@kao2.melbourne.sgi.com> <20011112.222348.102614983.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Keith Owens <kaos@ocs.com.au>
>    Date: Tue, 13 Nov 2001 17:16:26 +1100
> 
>    That breaks objects which have other __section__(".data.exit") info
>    which is not marked const.  I put a comment just above that change...
> 
> Then change the other definition of that macro to
> _NOT_ be const, and then fixup each and every driver
> to drop the const directive in their table declaration.

...and after all that work is done, change the PCI API in a stable
series. :)

grep const include/linux/pci.h

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

