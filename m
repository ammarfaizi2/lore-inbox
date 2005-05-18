Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVERTIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVERTIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVERTIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:08:09 -0400
Received: from mail2.dolby.com ([204.156.147.24]:44549 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S262238AbVERTHy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:07:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: RE: Illegal use of reserved word in system.h
Date: Wed, 18 May 2005 12:07:29 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Illegal use of reserved word in system.h
Thread-Index: AcVb3CWqR9jjHW+dQRCA1b6GzlTlWwAADnyw
From: "Gilbert, John" <JGG@dolby.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
This looks like the source of some stupidity.
http://bugs.mysql.com/bug.php?id=555

Which is even more fun when you see this.
http://bugs.mysql.com/bug.php?id=10364

I think it's been in there a while, but only really blows up when built
under recent kernels.
I agree, it's probably not the right way to go.
John G.

-----Original Message-----
From: Adrian Bunk [mailto:bunk@stusta.de] 
Sent: Wednesday, May 18, 2005 12:02 PM
To: Gilbert, John
Cc: linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h

On Wed, May 18, 2005 at 11:23:33AM -0700, Gilbert, John wrote:

> Hello all,

Hi John,

>...
> Examples: The use of "new" in the macro __cmpxchg in system.h. This 
>hits  MySQL which links into the kernel headers to determine if the 
>platform  is SMP aware or not (don't ask me why.) ...

I haven't ever seen MySQL doing something that stupid (stupid because if
it's required, it _really_ has to be done at runtime).

Which version of MySQL have you seen such an SMP check in?

> John Gilbert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed




-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you are not
the intended recipient, delete this message.  If you are not the intended
recipient, disclosing, copying, distributing, or taking any action based on
this message is strictly prohibited.

