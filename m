Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSEGBb4>; Mon, 6 May 2002 21:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315280AbSEGBbz>; Mon, 6 May 2002 21:31:55 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:64269 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315279AbSEGBbz>; Mon, 6 May 2002 21:31:55 -0400
Message-Id: <5.1.0.14.2.20020507022951.01fadc60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 May 2002 02:32:15 +0100
To: David Gibson <david@gibson.dropbear.id.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: TRIVIAL: Remove warning in mm/memory.c
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        trivial@rustcorp.com.au
In-Reply-To: <20020507011013.GD1163@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is already removed in 2.5.14!

Best regards,

         Anton

At 02:10 07/05/02, David Gibson wrote:
>Linus, please apply.  This patch removes an unused variable in
>mm/memory.c.
>
>diff -urN /home/dgibson/kernel/linuxppc-2.5/mm/memory.c 
>linux-bluefish/mm/memory.c
>--- /home/dgibson/kernel/linuxppc-2.5/mm/memory.c       Fri May  3 
>22:55:10 2002
>+++ linux-bluefish/mm/memory.c  Tue May  7 10:06:44 2002
>@@ -874,7 +874,6 @@
>                 end = PMD_SIZE;
>         pfn = phys_addr >> PAGE_SHIFT;
>         do {
>-               struct page *page;
>                 pte_t oldpage = ptep_get_and_clear(pte);
>
>                 if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
>
>
>--
>David Gibson                    | For every complex problem there is a
>david@gibson.dropbear.id.au     | solution which is simple, neat and
>                                 | wrong.  -- H.L. Mencken
>http://www.ozlabs.org/people/dgibson
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

