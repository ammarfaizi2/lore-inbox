Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbRCWXJG>; Fri, 23 Mar 2001 18:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131506AbRCWXIq>; Fri, 23 Mar 2001 18:08:46 -0500
Received: from inet-smtp4.oracle.com ([209.246.15.58]:40697 "EHLO
	inet-smtp4.oracle.com") by vger.kernel.org with ESMTP
	id <S131503AbRCWXIn>; Fri, 23 Mar 2001 18:08:43 -0500
Message-ID: <3ABBD639.12BE1035@oracle.com>
Date: Sat, 24 Mar 2001 00:03:21 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can't get serial.c to work with Xircom Cardbus Ethernet+Modem
In-Reply-To: <012301c0b357$3d29cc50$1601a8c0@zeusinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> 
> Hi all,
> 
> I saw a discussion on this list about this problem earlier, but could not
> find that it had actually been resolved.

That was me :) and no, it doesn't work. Jeff Garzik asked me to enable
 a couple debug #defines in serial.c, apply patches to serial.c and
 finally disable i82365 support but as of now it doesn't work.

It looks like we have the same card with modem @ 0x1880.

[snip]

> Any ideas?  I may look at it more tomorrow.  For now I'm back to using
> serial_cb which still works fine (even though that apparently suprises many
> people).

:) this is -pre4 with serial_cb which works fine, and always has...

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p17/2.4.3p6 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
