Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRJJBOQ>; Tue, 9 Oct 2001 21:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271978AbRJJBOH>; Tue, 9 Oct 2001 21:14:07 -0400
Received: from fes.whowhere.com ([209.185.123.154]:55147 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S272244AbRJJBNt>;
	Tue, 9 Oct 2001 21:13:49 -0400
To: linux-kernel@vger.kernel.org
Date: Tue, 09 Oct 2001 18:14:04 -0700
From: "Intergalactic Hitchhiker" <hitchhiker@lycos.com>
Message-ID: <FOAKNELNPLJNFBAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: hitchhiker@lycos.com
X-Mailer: MailCity Service
Subject: __alloc_pages failed on 2.4.10
X-Sender-Ip: 64.60.121.146
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i get these after some time on 2.4.10:

__alloc_pages: 0-order allocation failed (gfp=0x20/0) from c01250e0
__alloc_pages: 0-order allocation failed (gfp=0x20/0) from c01250e0
__alloc_pages: 0-order allocation failed (gfp=0x20/0) from c01250e0
__alloc_pages: 0-order allocation failed (gfp=0x20/0) from c01250e0
....

System.map:
...
c0124f10 t rmqueue
c01250c8 T _alloc_pages
c01250e4 t balance_classzone
c0125264 T __alloc_pages
c0125460 T __get_free_pages
c0125478 T get_zeroed_page
c01254a4 T __free_pages
c01254c0 T free_pages
...

- gagan




Make a difference, help support the relief efforts in the U.S.
http://clubs.lycos.com/live/events/september11.asp
