Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276081AbRI1OmS>; Fri, 28 Sep 2001 10:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276078AbRI1OmI>; Fri, 28 Sep 2001 10:42:08 -0400
Received: from sushi.toad.net ([162.33.130.105]:49544 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276077AbRI1Olv>;
	Fri, 28 Sep 2001 10:41:51 -0400
Message-ID: <3BB48C29.356901F1@mail.com>
Date: Fri, 28 Sep 2001 10:41:45 -0400
From: Thomas Hood <jdthood@mail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stelian Pop <stelian.pop@fr.alcove.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
In-Reply-To: <3BB47F7F.DE2FD301@mail.com> <20010928160250.K21524@come.alcove-fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> What about making a conditional on 'is_sony_vaio_laptop' here ?
> (but you need to extends the conditionnal export of this variable
> from dmi_scan.c / i386_ksyms.c).

In addition to applying the patch I just sent
(thood-pnpbiosvaio-patch-20010928-3), you will have
to move the definition of is_sony_vaio_laptop outside
the #ifdefs in arch/i386/kernel/dmi_scan.c and i386_ksyms.c

You or Alan:  For the cleaned up patch, do we export this
variable unconditionally?

--
Thomas
