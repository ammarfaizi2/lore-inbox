Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132514AbRDOX4q>; Sun, 15 Apr 2001 19:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132745AbRDOX4d>; Sun, 15 Apr 2001 19:56:33 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:746 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132142AbRDOX4S>; Sun, 15 Apr 2001 19:56:18 -0400
Message-Id: <5.0.2.1.2.20010416005604.00ac8ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 16 Apr 2001 00:58:03 +0100
To: esr@thyrsus.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: CML2 1.1.2 is available
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010415143316.A6115@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:33 15/04/2001, Eric S. Raymond wrote:
>The latest version is always available at http://www.tuxedo.org/~esr/cml2/
>Release 1.1.2: Sun Apr 15 14:26:07 EDT 2001
>         * Synchronized with 2.4.4-pre3.
>         * Screen flicker in menuconfig is gone.
>         * KEY_HOME and KEY_END now go to top or bottom of menu.
>         * Zack Weinberg's patch reorganizing the block devices menus.
>The screen flicker fix should also speed up general responsiveness.

Few comments:

When .config is missing and error is emitted when running make menuconfig 
(or any other I guess) for the first time. Should this be the case? It's 
ignored so ok but still would be nice not to have an error.

In ttyconfig: If type 'a' then enter then 'a' then enter then 'v' then 
enter it crashes out... Might be specific to where you are at the time. 
Sorry don't remember.

Good performance going up/down in menuconfig now. Even on my Pentium 133S! 
Excellent work! (fastmode on)

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

