Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132493AbRCZRDN>; Mon, 26 Mar 2001 12:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132491AbRCZRDF>; Mon, 26 Mar 2001 12:03:05 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19181 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132488AbRCZRC4>;
	Mon, 26 Mar 2001 12:02:56 -0500
Message-ID: <3ABF7615.ED51BB6D@mandrakesoft.com>
Date: Mon, 26 Mar 2001 12:02:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita.don.sitek.net>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] static zero initializers removal
In-Reply-To: <20010326163004.A14762@debian>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll take a look at merging the drivers/net part of this patch, except
for where it touches drivers/net/wan.

Andrey -- for maintainers at least, it might be nice to split these up
via subsystem -- one patch for drivers/isdn, one patch for drivers/char,
etc.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
