Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267508AbRGRRqc>; Wed, 18 Jul 2001 13:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbRGRRqW>; Wed, 18 Jul 2001 13:46:22 -0400
Received: from web14405.mail.yahoo.com ([216.136.174.62]:10258 "HELO
	web14405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267508AbRGRRqI>; Wed, 18 Jul 2001 13:46:08 -0400
Message-ID: <20010718174612.48434.qmail@web14405.mail.yahoo.com>
Date: Wed, 18 Jul 2001 10:46:12 -0700 (PDT)
From: Rajeev Bector <rajeev_bector@yahoo.com>
Subject: vmalloc and kiobuf questions ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MM Gurus, 
  In trying to understand how to map driver
memory into user space memory, I have the following
questions:

1) Is there a limit to how much memory
   I can allocate using vmalloc() ?
   (This is regular RAM)
2) I want to map the vmalloc'ed memory
   to user space via mmap(). I've read
   that remap_page_range() will not do it
   and I have to do it using nopage
   handlers ? Is that true ? Is there
   a simple answer to why is that the case ?

3) I've also read the kiobufs will simplify
   all this. Is there a documentation on 
   kiobufs - what they can and cannot do ?
   Are kiobufs part of the standard kernel
   now ?
Thanks in advance for your answers !

Rajeev


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
