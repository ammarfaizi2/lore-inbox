Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319672AbSIMO55>; Fri, 13 Sep 2002 10:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319673AbSIMO54>; Fri, 13 Sep 2002 10:57:56 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:63383 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S319672AbSIMO5z>; Fri, 13 Sep 2002 10:57:55 -0400
From: "syam" <syam@cisco.com>
To: "Richard Zidlicky" <rz@linux-m68k.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.19 Oops error
Date: Fri, 13 Sep 2002 08:01:16 -0700
Message-ID: <BOEAKBEECIJEDIMOJJJOOEGKCEAA.syam@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020913115952.A1796@linux-m68k.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,
Will running memtest fix the corruption? How to avoid such corruptions for
kernel 2.4.19?

Regards,
Syam

-----Original Message-----
From: Richard Zidlicky [mailto:rz@linux-m68k.org]
Sent: Friday, September 13, 2002 3:00 AM
To: Syam Sundar V Appala
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.19 Oops error


On Wed, Sep 11, 2002 at 08:23:09PM -0700, Syam Sundar V Appala wrote:
> Hello,
> I am relatively new to linux and I am facing the following problem. Can
> someone explain what is going on?
>
> Oops:
> ---
> EXT2-fs error (device ide0(3,1)): ext2_check_page: bad entry in directory
> #21179
> 6: unaligned directory entry - offset=0, inode=4294967295, rec_len=65535,
> name_l
> en=255

some inode was ovewritten by 0xfffffff...., look back in the log for other
strange messages. Run memtest.

Richard

