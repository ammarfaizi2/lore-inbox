Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289981AbSAWTLE>; Wed, 23 Jan 2002 14:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289979AbSAWTKp>; Wed, 23 Jan 2002 14:10:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:5572 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289974AbSAWTKl>;
	Wed, 23 Jan 2002 14:10:41 -0500
Subject: Re: [PATCH *] rmap VM, version 12
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, owner-linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD53A5C76.36FD7F7A-ON88256B4A.0069B25C@boulder.ibm.com>
From: "Badari Pulavarty" <badari@us.ibm.com>
Date: Wed, 23 Jan 2002 11:11:35 -0800
X-MIMETrack: Serialize by Router on D03NM044/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 01/23/2002 12:10:38 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik,

I just tried to boot 2.4.17+rmap12 turning off HIGHMEM and it booted just
fine.
So it has to do with some HIGHMEM change happend between  rmap11c and
rmap12.

Does this help ?

Thanks,
Badari



                                                                                                         
                    Rik van Riel                                                                         
                    <riel@conectiv       To:     Badari Pulavarty/Beaverton/IBM@IBMUS                    
                    a.com.br>            cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>    
                    Sent by:             Subject:     Re: [PATCH *] rmap VM, version 12                  
                    owner-linux-mm                                                                       
                    @kvack.org                                                                           
                                                                                                         
                                                                                                         
                    01/23/02 11:05                                                                       
                    AM                                                                                   
                                                                                                         
                                                                                                         



On Wed, 23 Jan 2002, Badari Pulavarty wrote:

> Does this explain why my SMP box does not boot with rmap12 ? It works
fine
> with rmap11c.
>
> Machine: 4x  500MHz Pentium Pro with 3GB RAM
>
> When I tried to boot 2.4.17+rmap12, last message I see is
>
> uncompressing linux ...
> booting ..

At this point we're not even near using pagetables yet,
so I guess this is something else ...

(I'm not 100% sure, though)

kind regards,

Rik
--
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/                   http://distro.conectiva.com/

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/




