Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRGNQm2>; Sat, 14 Jul 2001 12:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbRGNQmS>; Sat, 14 Jul 2001 12:42:18 -0400
Received: from t2.redhat.com ([199.183.24.243]:54258 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263089AbRGNQmG>; Sat, 14 Jul 2001 12:42:06 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200107141414.f6EEEjQ05792@ns.caldera.de> 
In-Reply-To: <200107141414.f6EEEjQ05792@ns.caldera.de> 
To: hch@caldera.de (Christoph Hellwig)
Cc: Gunther.Mayer@t-online.de (Gunther Mayer), paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Jul 2001 17:41:46 +0100
Message-ID: <17461.995128906@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hch@caldera.de said:
>  Why doe people reverse Jeff's s/malloc.h/slab.h/ changes all the
> time.  Malloc.h does nothing but including slab.h and should just die.

"malloc.h" is generic. "slab.h" exposes an implementation detail.

Why should we change code to include slab.h? 

Should we also rename other sanely-named include files to expose 
implementation details? rwsem-xadd.h? kmod-userhelper.h?

--
dwmw2


