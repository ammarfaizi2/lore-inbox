Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWC0LZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWC0LZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWC0LZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:25:24 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:42270 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750851AbWC0LZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:25:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lFHVu8c/wabljTdoAG+d54KL9IdC+IbdWu2X03+ldzzDS+muP1lbX56/mxblk3YjDIMTY8fa6rbvAw5hlO5JvMSgJGsY7QqiNP9pBRWn/ctBgVhlJK2BDv+YW4h0gjG+P3pPsKuKxfENXZYB9aCygyMlljB3JZ4ZJfo0aIsw5zw=
Message-ID: <bd7767e40603270325g71d39837if3bca8a05be39ace@mail.gmail.com>
Date: Mon, 27 Mar 2006 16:55:22 +0530
From: "Holy Aavu" <holyaavu@gmail.com>
To: mikado4vn@gmail.com
Subject: Re: Virtual Serial Port
Cc: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <442582B8.8040403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <442582B8.8040403@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/06, Mikado <mikado4vn@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> My machine has only one serial port. Now I want to add more *software*
> (virtual) serial ports. I also want to make a virtual serial cable
> between a real serial port and a virtual one OR between virtual ports.
> Is there any way to solve that problem in our universe?

I have a doubt... I am not sure if you can have a full working
solution to make all programs run using the virtual serial ports.
Because, there *might* be some programs which actually use the 'in'
and 'out' instructions of the processor directly from a user space
program. (After calling iopl/ioperm etc to elevate their I/O
privileges to directly use the IO ports) I dont think even a kernel
change can help in that case...

Is my understanding correct or am I missing something?

>
> Thanks,
> Mikado.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.2 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFEJYK3NWc9T2Wr2JcRAro+AKCMMf5So3sPJ+gXzSN+eYk0RXBxsQCg2V6I
> UK2pvLjQIECVc3e1//7d0WE=
> =GroY
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
