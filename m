Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292377AbSBUNv2>; Thu, 21 Feb 2002 08:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292384AbSBUNvS>; Thu, 21 Feb 2002 08:51:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21776 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292377AbSBUNvK>;
	Thu, 21 Feb 2002 08:51:10 -0500
Message-ID: <3C74FB4C.280DBE53@mandrakesoft.com>
Date: Thu, 21 Feb 2002 08:51:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
CC: Roman Zippel <zippel@linux-m68k.org>
Subject: Yet another config language...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been pointed to eCos's config language, which seems to have a lot
of desireable properties:  it seems compatible with our needs (no global
dependencies, all info in one file, just-plop-down-driver.conf like),
it's implemented, fully documented, and most importantly (IMO),
it looks possible to modify their config parser to read CML1, which
allows us to (a) prove the new design and (b) transition slowly.

Language overview and some quick samples:
	http://sources.redhat.com/ecos/docs-latest/cdl/language.html

Language reference:
	http://sources.redhat.com/ecos/docs-latest/cdl/reference.html

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
