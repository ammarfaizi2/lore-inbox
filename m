Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSIWDBb>; Sun, 22 Sep 2002 23:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264905AbSIWDBb>; Sun, 22 Sep 2002 23:01:31 -0400
Received: from nameservices.net ([208.234.25.16]:48645 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264903AbSIWDBa>;
	Sun, 22 Sep 2002 23:01:30 -0400
Message-ID: <3D8E85F3.D57C292F@opersys.com>
Date: Sun, 22 Sep 2002 23:09:39 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
References: <3D8E8371.D2070D87@opersys.com> <20020923030312.GM20520@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo Carvalho de Melo wrote:
> Why this ifdef hell and not something like:
> 
>         lockbuf_lock();
>         bla
>         logbuf_unlock();
> 
> and have this defined in a header, say printk.h or whatever, with the
> ifdefs?

You're right, this is somewhat insane ;)

We'll fix it, thanks.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
