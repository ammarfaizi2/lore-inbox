Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291633AbSBTEf1>; Tue, 19 Feb 2002 23:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291631AbSBTEfS>; Tue, 19 Feb 2002 23:35:18 -0500
Received: from c9mailgw.prontomail.com ([216.163.188.201]:52242 "EHLO
	C9Mailgw05.amadis.com") by vger.kernel.org with ESMTP
	id <S291633AbSBTEfC>; Tue, 19 Feb 2002 23:35:02 -0500
Message-ID: <3C73272B.9BDE55CE@starband.net>
Date: Tue, 19 Feb 2002 23:33:47 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: make install doesn't work for kernel factories
In-Reply-To: <20020220041413.GC29004@vnl.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you looked at http://www.installkernel.com/ ?
ik -i does the install.

Dale Amon wrote:

> The following does not work:
>
>         make DESTDIR=/my/target/root install
>
> it calls
>
> exec /sbin/installkernel 2.4.17 bzImage /my/source/directory/linux-2.4.17/System.map
>
> and proceeds to drop it on top of the local machine's
> kernel. installkernel should honor the selection of
> a different root.
>
> --
> ------------------------------------------------------
>     Nuke bin Laden:           Dale Amon, CEO/MD
>   improve the global          Islandone Society
>      gene pool.               www.islandone.org
> ------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

