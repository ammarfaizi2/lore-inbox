Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbRCAEFX>; Wed, 28 Feb 2001 23:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbRCAEFN>; Wed, 28 Feb 2001 23:05:13 -0500
Received: from shared1-qin.whowhere.com ([209.185.123.111]:24736 "HELO
	shared1-mail.whowhere.com") by vger.kernel.org with SMTP
	id <S129496AbRCAEE7>; Wed, 28 Feb 2001 23:04:59 -0500
To: "Erik Mouw" <J.A.K.Mouw@ITS.TUDelft.NL>
Date: Wed, 28 Feb 2001 23:04:34 -0500
From: "David Anderson" <daveanderson@eudoramail.com>
Message-ID: <MNNCKGACCLMNDAAA@shared1-mail.whowhere.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: on
Reply-To: daveanderson@eudoramail.com
X-Mailer: MailCity Service
Subject: Re: Can't compilete 2.4.2 kernel
X-Sender-Ip: 209.245.97.40
Organization: QUALCOMM Eudora Web-Mail  (http://www.eudoramail.com:80) 
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

THANK YOU so much, Erik.  You are now my new hero.  :)

Worked like a charm!  Thanks again. 
--

On Thu, 1 Mar 2001 01:27:17    Erik Mouw wrote:
>On Wed, Feb 28, 2001 at 09:32:09AM -0500, David Anderson wrote:
>> *CC daveanderson@eudoramail.com* on reply.
>> 
>> ln -s linux-2.4 linux 
>> 
>> That helps a bit.  Here's what I get now when doing 'make bzImage':
>> 
>> In file included from /usr/src/linux/include/linux/string.h:21,
>> from /usr/src/linux/include/linux/fs.h:23,
>> from /usr/src/linux/include/linux/capability.h:17,
>> from /usr/src/linux/include/linux/binfmts.h:5,
>> from /usr/src/linux/include/linux/sched.h:9,
>> from /usr/src/linux/include/linux/mm.h:4,
>> from /usr/src/linux/include/linux/slab.h:14,
>> from /usr/src/linux/include/linux/proc_fs.h:5,
>> from init/main.c:15:
>> /usr/src/linux/include/asm/string.h:305: `current' undeclared (first use in this function)
>> /usr/src/linux/include/asm/string.h: In function `__memcpy3d':
>> /usr/src/linux/include/asm/string.h:312: `current' undeclared (first use in this function)
>> make: *** [init/main.o] Error 1
>
>Known problem. Disable "SMP support" for Athlon CPUs.
>
>
>Erik
>
>-- 
>J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
>of Electrical Engineering, Faculty of Information Technology and Systems,
>Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
>Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
>WWW: http://www-ict.its.tudelft.nl/~erik/
>


Join 18 million Eudora users by signing up for a free Eudora Web-Mail account at http://www.eudoramail.com
