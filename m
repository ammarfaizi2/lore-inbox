Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKHVar>; Wed, 8 Nov 2000 16:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129187AbQKHVah>; Wed, 8 Nov 2000 16:30:37 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:9233 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129112AbQKHVaZ>;
	Wed, 8 Nov 2000 16:30:25 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Timur Tabi <ttabi@interactivesi.com>
cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: multiple definition of `__module_kernel_version' 
In-Reply-To: Your message of "Wed, 08 Nov 2000 15:15:59 MDT."
             <20001108211614Z129915-31179+2047@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Nov 2000 08:30:19 +1100
Message-ID: <13538.973719019@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2000 15:15:59 -0600, 
Timur Tabi <ttabi@interactivesi.com> wrote:
>../support/schedule.h:16: parse error
>
>and line 16 says:
>
>#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)

#include <linux/version.h>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
