Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbRFMKSb>; Wed, 13 Jun 2001 06:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbRFMKSV>; Wed, 13 Jun 2001 06:18:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27300 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262873AbRFMKSN>;
	Wed, 13 Jun 2001 06:18:13 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.15840.929759.844803@pizda.ninka.net>
Date: Wed, 13 Jun 2001 03:18:08 -0700 (PDT)
To: DJBARROW@de.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c
In-Reply-To: <C1256A6A.0037540A.00@d12mta09.de.ibm.com>
In-Reply-To: <C1256A6A.0037540A.00@d12mta09.de.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DJBARROW@de.ibm.com writes:
 > Here is the patch again for the benefit of those who are allergic to
 > opening enclosures.

Yes, this one is for those who are not allergic to line-breaks messing
up the patch, it seems :-)

The only reservation I had was wrt. procfs, but it dawned on me that
we init procfs explicitly in init/main.c before initcalls are made.

So I've fixed up the line breaks and coding style issues, and applied
your patch.  Thanks.

Later,
David S. Miller
davem@redhat.com
