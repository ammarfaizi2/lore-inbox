Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbRBLIuD>; Mon, 12 Feb 2001 03:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbRBLIty>; Mon, 12 Feb 2001 03:49:54 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:4873 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129114AbRBLItn>;
	Mon, 12 Feb 2001 03:49:43 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Ph. Marek" <marek@mail.bmlv.gv.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.[01] and duron - unresolved symbol _mmx_memcpy 
In-Reply-To: Your message of "Mon, 12 Feb 2001 08:04:59 BST."
             <3.0.6.32.20010212080459.0090ce80@pop3.bmlv.gv.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Feb 2001 19:49:36 +1100
Message-ID: <22453.981967776@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001 08:04:59 +0100, 
"Ph. Marek" <marek@mail.bmlv.gv.at> wrote:
>Some time ago I tried 2.4.0 compiled with option for duron-processors,
>yesterday I tried 2.4.1; both give problems on insmod/modprobe with some
>modules, eg. tulip.
>
>The offending function is _mmx_memcpy

I need the output from these commands on a running 2.4.x kernel
compiled for duron.

grep _mmx_memcpy /proc/ksyms
strings -a `/sbin/modprobe -l '*tulip*'` | grep _mmx_memcpy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
