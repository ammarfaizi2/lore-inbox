Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264323AbRFGF5m>; Thu, 7 Jun 2001 01:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264325AbRFGF5c>; Thu, 7 Jun 2001 01:57:32 -0400
Received: from beasley.gator.com ([63.197.87.202]:56836 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S264323AbRFGF5V>; Thu, 7 Jun 2001 01:57:21 -0400
From: "George Bonser" <george@gator.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Date: Wed, 6 Jun 2001 23:00:43 -0700
Message-ID: <CHEKKPICCNOGICGMDODJEECNDEAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <15135.5661.601195.943992@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What matters is the API under which a binary-only module may interface
> to the kernel.  Linus specifies that only the module exports in his
> tree fall into this API.

Ok, I was not aware of that stipulation. So to be very strict in the
interpretation, if there is a module export that is in the -ac kernels, ACME
could not make a binary module that depends on it until/if it makes it to
Linus' tree. Hmmm, Ok.

> As I stated in another email, the allowance of binary-only kernel
> modules is a special exception to the licensing of the kernel made by
> Linus.  The GPL by itself, does not allow this at all.

Right.  The GPL still allows one to "embrace and extend" it :-)

