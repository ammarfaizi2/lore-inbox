Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRDNQfh>; Sat, 14 Apr 2001 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbRDNQfR>; Sat, 14 Apr 2001 12:35:17 -0400
Received: from proxyd.rim.net ([206.51.26.194]:64420 "HELO mhs99ykf.rim.net")
	by vger.kernel.org with SMTP id <S132220AbRDNQfE>;
	Sat, 14 Apr 2001 12:35:04 -0400
Message-ID: <A9FD1B186B99D4119BCC00D0B75B4D8107F45B05@xch01ykf.rim.net>
From: Aaron Lunansky <alunansky@rim.net>
To: "'arthur-p@home.com'" <arthur-p@home.com>,
        "'axboe@suse.de'" <axboe@suse.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'jgarzik@mandrakesoft.com'" <jgarzik@mandrakesoft.com>
Subject: Re: loop problems continue in 2.4.3
Date: Sat, 14 Apr 2001 12:31:49 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you're intent on making it oops why not write a script to mount/unmount
it repeatedly?


Regards,
Aaron


-----Original Message-----
From: Arthur Pedyczak <arthur-p@home.com>
To: Jens Axboe <axboe@suse.de>
CC: Linux kernel list <linux-kernel@vger.kernel.org>; Jeff Garzik
<jgarzik@mandrakesoft.com>
Sent: Sat Apr 14 08:46:49 2001
Subject: Re: loop problems continue in 2.4.3

On Sat, 14 Apr 2001, Jens Axboe wrote:

[ SNIP..................]
> > =====================
> > Apr 13 20:50:03 cs865114-a kernel: Unable to handle kernel paging
request at virtual address 7e92bfd7
>
> Please disable syslog decoding (it sucks) and feed it through ksymoops
> instead.
>
> In other words, reproduce and dmesg | ksymoops instead.
>
>
I tried to reproduce the error this morning and couldn't. Same kernel
(2.4.3), same setup, same iso file. It mounted/unmounted 10 times with no
problem. DOn't know what to think.

Arthur

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
