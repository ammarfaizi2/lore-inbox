Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317596AbSFIMJ6>; Sun, 9 Jun 2002 08:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317601AbSFIMJ5>; Sun, 9 Jun 2002 08:09:57 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:34024 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317596AbSFIMJ4>; Sun, 9 Jun 2002 08:09:56 -0400
Date: Sun, 9 Jun 2002 14:09:57 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: comments on adding slist.h
Message-ID: <Pine.GSO.4.05.10206091405450.16324-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

since we've already list.h, what about adding slist.h for
single linked lists?

single linked list are often used within the kernel,
specifically slist_for_each() could be useful, since we can use
prefetch() there.  (slist_for_each could be used 42 times alone net/core)

any comments, (like, single linked lists are so trivial, there is no
need for a header file. or, the programmer has to take care of using
prefetch() when traversing single linked lists ...) are welcome.

thanks,
	tm

-- 
in some way i do, and in some way i don't.

