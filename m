Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288021AbSA3CEe>; Tue, 29 Jan 2002 21:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSA3CEZ>; Tue, 29 Jan 2002 21:04:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10387 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287939AbSA3CEW>; Tue, 29 Jan 2002 21:04:22 -0500
Message-ID: <3C575435.C123186@us.ibm.com>
Date: Tue, 29 Jan 2002 18:02:29 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: linux-kernel@vger.kernel.org, mingo@redhat.com, linux-raid@vger.kernel.org
Subject: Re: Could not compile md/raid5.c and md/multipath.c in 2.5.3-pre3
In-Reply-To: <3C571DB2.4E0C0436@us.ibm.com> <20020130042025.051ee424.johnpol@2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> 
> On Tue, 29 Jan 2002 14:09:54 -0800
> Mingming cao <cmm@us.ibm.com> wrote:
> 
> > Hello,
> 
> Good time of day.
> 
> > -march=i686    -c -o raid5.o raid5.c
> > In file included from raid5.c:23:
> > /home/ming/views/253-pre3/include/linux/raid/raid5.h:218: parse error
> > before `md_wait_queue_head_t'
> > /home/ming/views/253-pre3/include/linux/raid/raid5.h:218: warning: no
> > semicolon
> > at end of struct or union
> > /home/ming/views/253-pre3/include/linux/raid/raid5.h:222: parse error
> > before `device_lock'
> > ......
> > for now.  Could someone fix this?
> 
> I hope this patch will help you.
> 
> This patch is also cc'ed to Ingo Molnar, who is one of the maintainers of
> multiple discs support. Is it right, Ingo?
> Or noone should annoy anyone with such things?
> 
Hello Evgeniy,

I omitted similar compile errors in the last email.  raid5.c and
multipath.c referenced a lot data structures defined in
md_compatible.h,  besides the two you added in your fix......

Thank you for your help.
-- 
Mingming Cao
IBM Linux Technology Center
503-578-5024  IBM T/L: 775-5024
cmm@us.ibm.com
http://www.ibm.com/linux/ltc
