Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271818AbRIHTHh>; Sat, 8 Sep 2001 15:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271820AbRIHTH1>; Sat, 8 Sep 2001 15:07:27 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:49372 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S271818AbRIHTHK>; Sat, 8 Sep 2001 15:07:10 -0400
Message-Id: <200109081906.f88J6bY02298@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: "Hamid Hashemi Golpayegani" <hamid@morva.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: What is error means ?!
Date: Sat, 8 Sep 2001 15:06:43 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <001001c137d8$84f77cc0$0100a8c0@hashemi>
In-Reply-To: <001001c137d8$84f77cc0$0100a8c0@hashemi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That would be an oops (actually a couple).  See 
Documentation/oops-tracing.txt for details on how to run it through 
ksymoops.  Also see REPORTING-BUGS for additional necessary information 
(start with kernel and gcc versions).

Offhand, I'd say the kernel freaked out under extreme memory pressure.  If 
you're using a 2.4.x below .8, try upgrading the kernel first; the early 
ones had some fun VM issues.

	-- Brian

On Friday 07 September 2001 04:06 pm, Hamid Hashemi Golpayegani wrote:
> Hi ,
>
> I got this error in my messages sometimes and my network services ( TCP
> Services ) stop responding but when I ping this machine the pings works
> cool and the routing also works . But I can't login to the machine .
> Any idea that what is this message means ?!
>
> Sep  7 17:48:00 marmar4 kernel: Unable to handle kernel paging request
> at virtual address 85bd6bcc Sep  7 17:48:00 marmar4 kernel:
> current->tss.cr3 = 00101000, %cr3 = 00101000 Sep  7 17:48:00 marmar4
> kernel: *pde = 00000000 Sep  7 17:48:00 marmar4 kernel: Oops: 0002
>
