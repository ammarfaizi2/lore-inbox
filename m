Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbTCOPBd>; Sat, 15 Mar 2003 10:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbTCOPBd>; Sat, 15 Mar 2003 10:01:33 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:45321 "EHLO
	doughboy.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261460AbTCOPBc>; Sat, 15 Mar 2003 10:01:32 -0500
Message-ID: <3E734594.3080508@snapgear.com>
Date: Sun, 16 Mar 2003 01:24:04 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include stddef.h in include/linux/list.h
References: <200303111907.h2BJ72502778@hera.kernel.org> <20030311153859.A17036@redhat.com>
In-Reply-To: <20030311153859.A17036@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Benjamin LaHaise wrote:
> On Tue, Mar 11, 2003 at 05:47:54PM +0000, Linux Kernel Mailing List wrote:
> 
>>diff -Nru a/include/linux/list.h b/include/linux/list.h
>>--- a/include/linux/list.h	Tue Mar 11 11:07:05 2003
>>+++ b/include/linux/list.h	Tue Mar 11 11:07:05 2003
>>@@ -3,6 +3,7 @@
>> 
>> #ifdef __KERNEL__
>> 
>>+#include <linux/stddef.h>
>> #include <linux/prefetch.h>
>> #include <linux/stddef.h>
>> #include <asm/system.h>
> 
> 
> Huh?  Surely you meant to delete the extra stddef.h include...

No the original patch included stddef.h, when none was included.
Obviously 2 patch sets have been applied post 2.5.64 that are
trying to do the same thing.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

