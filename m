Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSFXVC3>; Mon, 24 Jun 2002 17:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSFXVC2>; Mon, 24 Jun 2002 17:02:28 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:17554 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315276AbSFXVC1>; Mon, 24 Jun 2002 17:02:27 -0400
Subject: Re: [Lse-tech] Re: efficient copy_to_user and copy_from_user routines in
 Linux Kernel
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF74FDD393.9C0D100A-ON85256BE2.00737417@raleigh.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 24 Jun 2002 16:02:17 -0500
X-MIMETrack: Serialize by Router on D04NM108/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/24/2002 05:02:17 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>David Miller wrote..
 >If the code is going to become so much larger, move the implementation
>out of the header file and into arch/i386/lib/foo.S

>It makes no sense to inline it anymore if it is going to be
>implemented with so many instructions.
I will do that. Thanks.

Regards,
    Mala


   Mala Anand
   E-mail:manand@us.ibm.com
   Linux Technology Center - Performance
   Phone:838-8088; Tie-line:678-8088




                                                                                                                                               
                      "David S. Miller"                                                                                                        
                      <davem@redhat.com>               To:       Mala Anand/Austin/IBM@IBMUS                                                   
                      Sent by:                         cc:       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net                  
                      lse-tech-admin@lists.sour        Subject:  [Lse-tech] Re: efficient copy_to_user and copy_from_user routines in Linux    
                      ceforge.net                       Kernel                                                                                 
                                                                                                                                               
                                                                                                                                               
                      06/24/02 02:33 PM                                                                                                        
                                                                                                                                               
                                                                                                                                               



   From: "Mala Anand" <manand@us.ibm.com>
   Date: Mon, 24 Jun 2002 14:34:08 -0500




-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lse-tech



