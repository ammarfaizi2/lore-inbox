Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287431AbSACWFW>; Thu, 3 Jan 2002 17:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287420AbSACWFN>; Thu, 3 Jan 2002 17:05:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62690 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S287405AbSACWFE>;
	Thu, 3 Jan 2002 17:05:04 -0500
Message-ID: <3C34E1EE.D51D529@vnet.ibm.com>
Date: Thu, 03 Jan 2002 16:57:50 -0600
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Zhu <mylinuxk@yahoo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: The CURRENT macro
In-Reply-To: <20020103213455.34699.qmail@web14911.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Zhu wrote:
> 
> In Alessandro Rubini's book Linux Device Driver(Second
> Edition), Chatper 12, he said that "By accessing the
> fields in the request structure, usually by way of
> CURRENT" and "CURRENT is just a pointer into
> blk_dev[MAJOR_NR].request_queue". I know CURRENT is
> just a macro. Where can I find the definition of this
> macro?
> I just don't know how to get the struct request from
> the request_queue(a request_queue_t struct). CURRENT
> points to which field in the
> blk_dev[MAJOR_NR].request_queue? Thank you very much.

Heh!  Ignore that last one ...

Wrong current... you want CURRENT ... duh!  look in include/linux/blk.h

grep is your friend.

Regards,

Tom
-- 
Tom Gall - [embedded] [PPC64 | PPC32] Code Monkey
Peace, Love &                  "Where's the ka-boom? There was
Linux Technology Center         supposed to be an earth
http://www.ibm.com/linux/ltc/   shattering ka-boom!"
(w) tom_gall@vnet.ibm.com       -- Marvin Martian
(w) 507-253-4558
(h) tgall@rochcivictheatre.org
