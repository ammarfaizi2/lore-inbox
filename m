Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQLDMIh>; Mon, 4 Dec 2000 07:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbQLDMI1>; Mon, 4 Dec 2000 07:08:27 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:60822 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129413AbQLDMIU>; Mon, 4 Dec 2000 07:08:20 -0500
Message-ID: <3A2B82E8.26BCC5B1@uow.edu.au>
Date: Mon, 04 Dec 2000 22:41:28 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4: BUG at swap.c:271!
In-Reply-To: <Pine.Linu.4.10.10012040930550.654-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> Hi,
> 
> When stressing swap (virgin test12-pre4), I encounter the repeatable
> oops below once load builds to heavy.  The vmscan.c:UnlockPage(page)
> addition sets it off.  Appears 100% repeatable.
> 

Same here.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
