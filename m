Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136124AbRD0RZL>; Fri, 27 Apr 2001 13:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136131AbRD0RZC>; Fri, 27 Apr 2001 13:25:02 -0400
Received: from [209.225.10.21] ([209.225.10.21]:17682 "HELO mailrelay.local")
	by vger.kernel.org with SMTP id <S136124AbRD0RYw>;
	Fri, 27 Apr 2001 13:24:52 -0400
Message-ID: <3AE983A8.C5FEF63E@elsitio.com.ar>
Date: Fri, 27 Apr 2001 14:35:20 +0000
From: Federico Edelman Anaya <fedelman@elsitio.com.ar>
Reply-To: fedelman@elsitio.com.ar
Organization: El Sitio
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: FD in Kernel 2.4.x
In-Reply-To: <3AE9A692.4F0CC9B3@kegel.com> <3AE9802B.A19830A@elsitio.com.ar> <3AE9AA32.321B05BD@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# ./dklimits 10000
Can open 1020 AF_LOCAL sockets with socketpair
Can open 0 AF_INET sockets with socketpair
Can open 1021 fds
Can open 1021 files
Can poll 1025 sockets
Can bind 1021 ephemeral ports

Dan Kegel wrote:

> Federico Edelman Anaya wrote:
> >
> > Yeah .. I put in /etc/sysctl.conf
> >
> > fs.file-max=16384
> > fs.inode-max=65536
> >
> > But, in 2.4.3 doesn't support fs.inode-max .... :(
> >
> > Dan Kegel wrote:
> >
> > > > How can I increase the FD in the Kernel 2.4.3?
> > >
> > > echo 32768 > /proc/sys/fs/file-max
> > >
> > > See also http://www.kegel.com/c10k.html#limits.filehandles
>
> You don't need fs.inode-max under 2.4.
>
> Can you check something for me?  Run the program dklimits.c from
> http://www.kegel.com/dkftpbench/#tuning
> with argument 10000 and tell me what it prints.
> (Compile it with gcc -DLINUX dklimits.c.)
>
> - Dan

