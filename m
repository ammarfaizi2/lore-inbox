Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277317AbRJOHSf>; Mon, 15 Oct 2001 03:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277318AbRJOHSZ>; Mon, 15 Oct 2001 03:18:25 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:58499 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S277317AbRJOHSK>; Mon, 15 Oct 2001 03:18:10 -0400
Message-ID: <3BCA889B.6000504@blue-labs.org>
Date: Mon, 15 Oct 2001 02:56:27 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011013
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>
CC: mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re: 
In-Reply-To: <20011015062505.32762.qmail@mailweb33.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That should throw a segmentation fault, in the kernel an OOPS,  in this 
statement the code is trying to dereference a NULL pointer and store a 
value at 0x0.

David

Dinesh Gandhewar wrote:

>Hello,
>What is the effect of following statement at the end of function definition?
>*(int *)0 = 0;	
>Thanking you,
>Dinesh 
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


