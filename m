Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276090AbRI1O66>; Fri, 28 Sep 2001 10:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276097AbRI1O6s>; Fri, 28 Sep 2001 10:58:48 -0400
Received: from sushi.toad.net ([162.33.130.105]:47757 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276090AbRI1O6l>;
	Fri, 28 Sep 2001 10:58:41 -0400
Message-ID: <3BB4901B.D74A0350@mail.com>
Date: Fri, 28 Sep 2001 10:58:35 -0400
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

I said:
> In addition to applying the patch I just sent
> (thood-pnpbiosvaio-patch-20010928-3), you will have
> to move the definition of is_sony_vaio_laptop outside
> the #ifdefs in arch/i386/kernel/dmi_scan.c and i386_ksyms.c

... along with the functions that initialize it.  The easiest
thing to do is remove the #ifdef's and #endif's around the
sony_vaio_laptop stuff in those two files.  Is that the
ultimately correct thing to do?

--
Thomas
