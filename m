Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131404AbRANKGT>; Sun, 14 Jan 2001 05:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131827AbRANKGJ>; Sun, 14 Jan 2001 05:06:09 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48906 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131404AbRANKF6>;
	Sun, 14 Jan 2001 05:05:58 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Sun, 14 Jan 2001 09:43:21 -0000."
             <Pine.LNX.4.30.0101140922430.4887-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Jan 2001 21:05:51 +1100
Message-ID: <13920.979466751@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001 09:43:21 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>On Sun, 14 Jan 2001, Keith Owens wrote:
>> That forces the maintenance load back onto the binary supplier and
>> removes the questions from l-k, including many of the oops reports with
>> binary only drivers in the module list.
>
>No. The correct response to that is _already_ "You have a binary-only
>module. Even in the kernel it was compiled against, you are not supported.
>Goodbye".

I wish that Linus had never agreed to binary only modules.  But as long
as they are allowed, I want to detect problems with binary only modules
before they hit the rest of the kernel and end up as questions on l-k.

Note I said allowed, not supported.  I refuse to support any binary
only modules, my standard response to problems logged against binary
modules is "remove them and reproduce the problem".  Checking for ABI
violations is not supporting binary modules, it is detecting that they
are stuffed and telling the user to go pester their supplier instead of
polluting l-k with questions that will be ignored.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
