Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267522AbRGRSto>; Wed, 18 Jul 2001 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267523AbRGRStf>; Wed, 18 Jul 2001 14:49:35 -0400
Received: from zmsvr04.tais.net ([12.106.80.12]:54801 "EHLO zmsvr04.tais.net")
	by vger.kernel.org with ESMTP id <S267522AbRGRStR>;
	Wed, 18 Jul 2001 14:49:17 -0400
Subject: Re: vmalloc and kiobuf questions ?
To: rajeev_bector@yahoo.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF424F0CA5.5C889BB9-ON88256A8D.0066E43A@tais.net>
From: Ramil.Santamaria@tais.toshiba.com
Date: Wed, 18 Jul 2001 11:49:12 -0700
X-MIMETrack: Serialize by Router on zmsvr04/tais_external(Release 5.0.6a |January 17, 2001) at
 07/18/2001 11:49:22 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's also a good idea to mem_map_reserve( ) pages that will be remapped to
user space.

Ramil J.Santamaria
Toshiba America Information Systems
ramil.santamaria@tais.toshiba.com


                                                                                                                              
                    Rajeev Bector                                                                                             
                    <rajeev_bector@yahoo.com        To:     linux-kernel@vger.kernel.org                                      
                    >                               cc:                                                                       
                    Sent by:                        Subject:     vmalloc and kiobuf questions ?                               
                    linux-kernel-owner@vger.                                                                                  
                    kernel.org                                                                                                
                                                                                                                              
                                                                                                                              
                    07/18/2001 10:46 AM                                                                                       
                                                                                                                              
                                                                                                                              




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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




