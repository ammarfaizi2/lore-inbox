Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282540AbRLFTJd>; Thu, 6 Dec 2001 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282670AbRLFTJP>; Thu, 6 Dec 2001 14:09:15 -0500
Received: from dobit2.rug.ac.be ([157.193.42.8]:4038 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S282540AbRLFTI7>;
	Thu, 6 Dec 2001 14:08:59 -0500
Date: Thu, 6 Dec 2001 20:08:57 +0100 (MET)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: <linux-kernel@vger.kernel.org>
Subject: list_head makes me crazy
Message-ID: <Pine.GSO.4.31.0112062004520.2339-100000@eduserv.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HELP,

In include/asm-i386/processor.h, struct thread_struct I can add
	struct list_head *mylist;
but not
	struct list_head mylist;
while in both cases
	#include <linux/list.h>
is being used.

I really need this, so if anyone has the solution to my problem...

Thanks in advance, Frank.

