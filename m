Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRCIAjf>; Thu, 8 Mar 2001 19:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRCIAjZ>; Thu, 8 Mar 2001 19:39:25 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:18339 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130383AbRCIAjS>; Thu, 8 Mar 2001 19:39:18 -0500
Message-Id: <5.0.2.1.2.20010309003257.00abeac0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 09 Mar 2001 00:39:40 +0000
To: Rik van Riel <riel@conectiva.com.br>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] documentation mm.h + swap.h
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0103081807260.1314-100000@duckman.distro.con
 ectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:10 08/03/2001, Rik van Riel wrote:
>+ * There is also a hash table mapping (inode,offset) to the page
>+ * in memory if present. The lists for this hash table use the fields
>+ * page->next_hash and page->pprev_hash.

Shouldn't (inode,offset) be (inode,index), or possibly (mapping,index)?

>+ * For choosing which pages to swap out, inode pages carry a
>+ * PG_referenced bit, which is set any time the system accesses
>+ * that page through the (inode,offset) hash table. This referenced

And here, too?

I know these are small details, but just for completeness sake...

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

