Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130856AbQK2P5L>; Wed, 29 Nov 2000 10:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130835AbQK2P4w>; Wed, 29 Nov 2000 10:56:52 -0500
Received: from mail.iex.net ([192.156.196.5]:57249 "EHLO mail.iex.net")
        by vger.kernel.org with ESMTP id <S129961AbQK2P4q>;
        Wed, 29 Nov 2000 10:56:46 -0500
Message-ID: <3A252018.141FA3A@iex.net>
Date: Wed, 29 Nov 2000 08:26:16 -0700
From: Tim Sullivan <tsulliva@iex.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre3: paging problem
In-Reply-To: <3A250F85.EF1FD067@iex.net> <3A251361.CC904AC0@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> Run the oops messages through ksymoops please.  It is useless in this
> form.
> 

In this case, it is not very helpful.

ksymoops 2.3.5 on i686 2.4.0-test12-pre3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12-pre3/ (default)
     -m /usr/src/linux/System.map (default)

kernel: Unable to handle kernel paging request at virtual address
fffffffc
kernel: Unable to handle kernel paging request at virtual address
fffffffc
kernel: Unable to handle kernel paging request at virtual address
fffffffc


regards,

-tim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
