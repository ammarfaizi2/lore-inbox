Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130536AbRAITT4>; Tue, 9 Jan 2001 14:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRAITTq>; Tue, 9 Jan 2001 14:19:46 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:30763 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S130536AbRAITTb>; Tue, 9 Jan 2001 14:19:31 -0500
Message-ID: <3A5B6437.3BC23AD3@metabyte.com>
Date: Tue, 09 Jan 2001 11:19:19 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zaitcev@metabyte.com
Subject: Re: Linux 2.2.19pre7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2001 19:19:29.0480 (UTC) FILETIME=[168FF480:01C07A71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o Fix kwhich versus old bash (Pete Zaitcev) 

A small clarification may be in order here.

First, this patch comes from Miquel Smoorenburg, not from me.

Second, DaveM pointed out that it fixes a non-problem.
I stepped on a bug with an obscure kernel, I think it
was 2.2.18-pre3, which called kwhich with several arguments.
Current kernels call kwhich with one argument at a time,
so they are not affected.

-- Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
