Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135913AbREIItI>; Wed, 9 May 2001 04:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135914AbREIIs6>; Wed, 9 May 2001 04:48:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39944 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135913AbREIIsw>; Wed, 9 May 2001 04:48:52 -0400
Subject: Re: [PATCH] RAID5 NULL Checking Bug Fix
To: dmchan@stanford.edu (david chan)
Date: Wed, 9 May 2001 09:51:48 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), mingo@redhat.com (Ingo Molnar),
        calle@calle.in-berlin.de (Carsten Paeth), kkeil@suse.de (Karsten Keil),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.30.0105081923540.21906-100000@waulogy.stanford.edu> from "david chan" at May 08, 2001 07:32:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xPhG-0001q2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> In drivers/md/raid5.c, the author does not check to see if alloc_page() returns
> NULL. This patch also adds checks that return 1 (following the
> error-path convention in the respective function).

This is fixed in 2.4.4-ac and has been for a while (and a little more
cleanly in some respects). However it needs someone who knows the raid code
well to push the raid fixes on to Linus

Alan

