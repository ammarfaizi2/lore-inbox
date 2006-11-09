Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423777AbWKICEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423777AbWKICEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 21:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161786AbWKICEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 21:04:51 -0500
Received: from mail1.coralwave.com ([24.244.175.138]:25354 "EHLO
	mail1.coralwave.com") by vger.kernel.org with ESMTP
	id S1161785AbWKICEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 21:04:50 -0500
From: Jason Harrison <jharrison@linuxbs.org>
To: Steve Langasek <vorlon@debian.org>
Subject: Re: [patch] video: support for VGA hoses on alpha TITAN, TSUNAMI systems (ES45, DS25)
Date: Wed, 8 Nov 2006 21:04:37 -0500
User-Agent: KMail/1.9.5
References: <20061102083718.GC12267@mauritius.dodds.net> <20061102131443.918d6c2e.akpm@osdl.org> <20061104063510.GA7268@mauritius.dodds.net>
In-Reply-To: <20061104063510.GA7268@mauritius.dodds.net>
Cc: Eki <eki@sci.fi>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, thias.lelourd@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611082104.37349.jharrison@linuxbs.org>
X-IMAIL-SPAM-DNSBL: (v6net,8ca903a70134e863,65.77.130.111)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Just wanted to let you know I tested this patch 
http://people.debian.org/~vorlon/alpha-titan-video.patch on 2.6.18.2 sources 
and got the following errors during the compile.  The same 2.6.18.2 sources 
compile ok so I think this has something to do with the alpha-titan-video 
patch.  I hope this information is useful.  I do not know too much about 
debugging yet or I would have tried to provide more.

In file included from include/asm/io.h:250,
                 from include/linux/dmapool.h:14,
                 from include/linux/pci.h:564,
                 from arch/alpha/kernel/alpha_ksyms.c:16:
include/asm/core_titan.h: In function 'titan_ioportmap':
include/asm/core_titan.h:386: error: dereferencing pointer to incomplete type
make[1]: *** [arch/alpha/kernel/alpha_ksyms.o] Error 1
make: *** [arch/alpha/kernel] Error 2

Regards,
Jason Harrison
