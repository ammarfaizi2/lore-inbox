Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132095AbQKWAL6>; Wed, 22 Nov 2000 19:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132265AbQKWALs>; Wed, 22 Nov 2000 19:11:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47880 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S132095AbQKWALe>;
        Wed, 22 Nov 2000 19:11:34 -0500
Message-ID: <3A1C59A3.52AA42B3@mandrakesoft.com>
Date: Wed, 22 Nov 2000 18:41:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>
CC: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Mitchell Blank Jr <mitch@sfgoth.com>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <200011222305.AAA30264@cave.bitwizard.nl> <d366lflgvl.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> I think the most important issue is when doing header files to make
> sure they go with the driver code and not in include/linux unless
> there really is a reason to expose them to user space. No reason to
> export register definitions for Ethernet cards down there.

Agreed, that there are some headers that IMHO need to be moved out of
include/linux because they aren't used in userspace, and they aren't
public interfaces, nor shared across directories.

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
