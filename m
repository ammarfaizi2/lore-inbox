Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbRGQPbi>; Tue, 17 Jul 2001 11:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRGQPb3>; Tue, 17 Jul 2001 11:31:29 -0400
Received: from oe20.law3.hotmail.com ([209.185.240.124]:6161 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266582AbRGQPbR>;
	Tue, 17 Jul 2001 11:31:17 -0400
X-Originating-IP: [64.108.12.20]
Reply-To: "William Scott Lockwood III" <scottlockwood@hotmail.com>
From: "William Scott Lockwood III" <thatlinuxguy@hotmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <OE17UirmJJgWha8vFnq000074b6@hotmail.com>  <Pine.LNX.4.33.0107171532450.1817-100000@ketil.np> <7721.995383087@redhat.com>
Subject: [VERY OT] Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
Date: Tue, 17 Jul 2001 10:35:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE207Offjcu1lObtvrw000044b6@hotmail.com>
X-OriginalArrivalTime: 17 Jul 2001 15:31:16.0251 (UTC) FILETIME=[84D5C6B0:01C10ED5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id BAA12498

Oh, I understand attention to detail.  After spending eight years in the United States Navy as a Hospital Corpsman, you either understand attention to detail, or you are not a Corpsman any longer.  :-)  It just struck me as funny that, while an understanding of attention to detail is important, so is the way in which information is communicated.  In fact, it's almost as important as the information itself.  I've seen more fights start over how something was said, or not said - I'm sure you get the picture.  :-)

Me, I mainly lurk here for that very reason - I've received too much hatemail from posting to the list, so I try to follow it instead and see what I can learn.  Today, I learned that multiples of 1024 is actually Ki.  Thank you!  I did not know that.

Scott
----- Original Message ----- 
From: "David Woodhouse" <dwmw2@infradead.org>
To: "William Scott Lockwood III" <scottlockwood@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, July 17, 2001 10:18 AM
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo


| 
| thatlinuxguy@hotmail.com said:
| > It never ceases to amaze me how ANAL some people on this list are.
| > :-)
| 
| It's called attention to detail, and it's the _reason_ why a lot of people
| are here.
| 
| The correct prefix to signify a multiple of 1024 is 'Ki'.
| 
| Index: arch/i386/kernel/setup.c
| ===================================================================
| RCS file: /inst/cvs/linux/arch/i386/kernel/setup.c,v
| retrieving revision 1.4.2.57
| diff -u -r1.4.2.57 setup.c
| --- arch/i386/kernel/setup.c 2001/05/14 10:32:23 1.4.2.57
| +++ arch/i386/kernel/setup.c 2001/07/17 15:13:54
| @@ -2406,7 +2406,7 @@
| 
|   /* Cache size */
|   if (c->x86_cache_size >= 0)
| - p += sprintf(p, "cache size\t: %d KB\n", c->x86_cache_size);
| + p += sprintf(p, "cache size\t: %d KiB\n", c->x86_cache_size);
| 
|   /* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
|   fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
| 
| 
| --
| dwmw2
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
