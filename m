Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbRE0S7q>; Sun, 27 May 2001 14:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbRE0S7h>; Sun, 27 May 2001 14:59:37 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:59890 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S261335AbRE0S7Z>;
	Sun, 27 May 2001 14:59:25 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: problems with ac12 kernels and up
Date: Sun, 27 May 2001 14:59:17 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGKEEJCHAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> http://jcwren.com/linux/ac18.txt - ac18 dmesg dump
>> http://jcwren.com/linux/build.txt - sequence I'm using to build
>>
>> The apparent interleaved garbage closer to the bottom is exactly what
came
>> out on the console.  (Is linking to the dumps perferred over including it
in
>> the mail, or would folks prefer to have the text included?  Since I'm not
a
>
>The link is fine..
>
>> I also rebuilt the ac12 kernel, and tried again.  Same results as the
quoted
>> text above.
>
>This looks a lot like the superblock changes not only broke reiserfs but
also
>initd usage.
>
>Al ?

If it's of any help, here's the System.map around that EIP:

c017f0d0 T floppy_eject
c017f100 t get_dma_residue
c017f150 t rd_make_request
c017f280 t rd_ioctl
c017f380 t initrd_read
c017f3d0 t initrd_release
c017f420 t rd_open
c017f4b0 t rd_release

--John

