Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131858AbQKBOgu>; Thu, 2 Nov 2000 09:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131944AbQKBOgk>; Thu, 2 Nov 2000 09:36:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37640 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131858AbQKBOgc>;
	Thu, 2 Nov 2000 09:36:32 -0500
Message-ID: <3A017BCF.DAAE9827@mandrakesoft.com>
Date: Thu, 02 Nov 2000 09:35:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Thomas Sailer <sailer@ife.ee.ethz.ch>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <Pine.LNX.3.95.1001102091346.8760A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> The specification is bogus and should be fixed. select() is not
> a function that was designed to start/stop anything. Writing
> a specification to qualify some particular implementation's
> side-affects is patently wrong. ioctl() was designed to control
> things.
> 
> You should contact a committee member and get it fixed. Further,
> all should fail to write code to such a so-called specification.
> 
> If specifications are allowed to be written like this, soon
> the lights will go out when you open a file. This cannot be
> allowed. Don't support such diatribe.

We are stuck with the current OSS API, including warts aplenty, until
ALSA replaces it.  (but even then OSS will live on in infamy...)

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
