Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274303AbRITD7l>; Wed, 19 Sep 2001 23:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274304AbRITD7b>; Wed, 19 Sep 2001 23:59:31 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10196 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S274303AbRITD7X>; Wed, 19 Sep 2001 23:59:23 -0400
Date: Wed, 19 Sep 2001 22:01:03 -0600
Message-Id: <200109200401.f8K413n29745@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: drivers/char/sonypi.h broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Linus. I now find that drivers/char/sonypi.h has been broken in
2.4.10-pre12. I get the following compile errors:

sonypi.h:195: `SONYPI_EVENT_PKEY_P1' undeclared here (not in a function)
sonypi.h:195: initializer element for `sonypi_pkeyev[0].event' is not constant
sonypi.h:196: `SONYPI_EVENT_PKEY_P2' undeclared here (not in a function)
sonypi.h:196: initializer element for `sonypi_pkeyev[1].event' is not constant
sonypi.h:197: `SONYPI_EVENT_PKEY_P3' undeclared here (not in a function)
sonypi.h:197: initializer element for `sonypi_pkeyev[2].event' is not constant
make[2]: *** [sonypi.o] Error 1

I have no idea what the values should be, so I'm unable to generate a
patch. Hopefully the guilty party (i.e. the lazy bastard who sent in a
broken patch without bothering to compile the fucking thing first)
will be shamed into generating a patch ASAP.

Yes, I'm annoyed. So much for syncing up tonight with -pre12, testing
(yeah, some of us still believe in TESTING), and thence onto coding.
I've spent the evening flushing out other people's turds. Grrr.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
