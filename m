Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQKBFAe>; Thu, 2 Nov 2000 00:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130073AbQKBFAN>; Thu, 2 Nov 2000 00:00:13 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39951 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129573AbQKBFAF>;
	Thu, 2 Nov 2000 00:00:05 -0500
Message-ID: <3A00F4A7.81D2D3E1@mandrakesoft.com>
Date: Wed, 01 Nov 2000 23:59:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tom Rini <trini@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, garloff@suse.de,
        jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <Pine.Linu.4.10.10011020529050.1061-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> [root]:# gcc -v
> Reading specs from /usr/lib/gcc-lib/i586-linux-gnu/gcc-2.95.2/specs
> gcc version gcc-2.95.2 19991024 (release)
> [root]:# gcc -V 2.8.1 -v
> Using builtin specs.  <== danger Will Robinson. (think about includes etc)
> gcc driver version gcc-2.95.2 19991024 (release) executing gcc version 2.8.1
> [root]:# gcc -V 2.8.1 -b i486-linux-gnu -v
> Reading specs from /usr/lib/gcc-lib/i486-linux-gnu/2.8.1/specs
> gcc driver version gcc-2.95.2 19991024 (release) executing gcc version 2.8.1

Cool, looks like we are ok:

[jgarzik@rum linux_2_4]$ kgcc -v
Reading specs from
/usr/lib/gcc-lib/i586-mandrake-linux/egcs-2.91.66/specs
gcc driver version 2.95.3 19991030 (prerelease) executing gcc version
egcs-2.91.66

Thanks,

	Jeff


-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
