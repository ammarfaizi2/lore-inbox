Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276736AbRJBWLt>; Tue, 2 Oct 2001 18:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276734AbRJBWLk>; Tue, 2 Oct 2001 18:11:40 -0400
Received: from cs.columbia.edu ([128.59.16.20]:7553 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S276733AbRJBWLb>;
	Tue, 2 Oct 2001 18:11:31 -0400
Date: Tue, 2 Oct 2001 18:11:58 -0400
Message-Id: <200110022211.f92MBwE06003@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
In-Reply-To: <20010928160250.K21524@come.alcove-fr>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001 16:02:52 +0200, Stelian Pop <stelian.pop@fr.alcove.com> wrote:

> What about making a conditional on 'is_sony_vaio_laptop' here ?
> (but you need to extends the conditionnal export of this variable 
> from dmi_scan.c / i386_ksyms.c).

Well, the funny thing is, the same kernel doesn't boot on a Dell Inspiron 
laptop either, if PNP is enabled -- and the oops is the same. So it's not 
just Sony...

2.4.9-ac10 has no such issues on the same laptop, btw.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
