Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSEFTEg>; Mon, 6 May 2002 15:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314676AbSEFTEf>; Mon, 6 May 2002 15:04:35 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:38951 "EHLO
	tsmtp1.mail.isp") by vger.kernel.org with ESMTP id <S314657AbSEFTEc>;
	Mon, 6 May 2002 15:04:32 -0400
Date: Mon, 6 May 2002 21:07:27 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: John Stoffel <stoffel@casc.com>
Cc: Dan Kegel <dank@kegel.com>, "David S. Miller" <davem@redhat.com>,
        <khttpd-users@alt.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
Message-Id: <20020506210727.4ed05ba1.DiegoCG@teleline.es>
In-Reply-To: <15574.52864.321544.44124@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002 14:42:08 -0400
John Stoffel <stoffel@casc.com> escribió:
> And why does a Web server belong in the kernel?  I've never understood
> this, and I personally do not think it has any need to be there.  

But *f I have a dedicated web server, and I have a lot of traffic, *if* (and only if)
 I can take some performance advantages
from putting a web server into kernel space, I'd like to have those advantages.

> 
> <sarcasm>
> 
> Or maybe we should include kDNS and kftpd as well now?

Why not for dedicated servers if this can take some advantages for them?

> 
> </sarcasm>
> 
> An httpd server is a *user space* issue, not a kernel issue.

It's true. But I'd be an idiot if I can improve performance and I don't do it.

However, if an httpd can be as fast as an kernel space httpd it'd be a bad thing to put it
in kernel space.


> 
> John
>    John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
> 	 stoffel@lucent.com - http://www.lucent.com - 978-399-0479
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
