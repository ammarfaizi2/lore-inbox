Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277715AbRJIEYW>; Tue, 9 Oct 2001 00:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277716AbRJIEYM>; Tue, 9 Oct 2001 00:24:12 -0400
Received: from zok.SGI.COM ([204.94.215.101]:32963 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277715AbRJIEX5>;
	Tue, 9 Oct 2001 00:23:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Todd Roy <todd_m_roy@yahoo.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: jbd_preclean_buffer_check. 
In-Reply-To: Your message of "Mon, 08 Oct 2001 21:05:51 MST."
             <20011009040551.34486.qmail@web13606.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Oct 2001 14:24:18 +1000
Message-ID: <27179.1002601458@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001 21:05:51 -0700 (PDT), 
Todd Roy <todd_m_roy@yahoo.com> wrote:
>Sorry if this is old guys, but I just noticed
>that modules loop.o and md.o are broken in at least
>2.4.10-ac9
>and ac10, if  CONFIG_EXT3_FS=Y, JBD_CONFIG=Y and
>CONFIG_JBD_DEBUG=Y:
>
>typical modprobe output:
>/lib/modules/2.4.10-ac10/kernel/drivers/md/md.o:
>unresolved symbol jbd_preclean_buffer_check

Work for me.  Did you get bitten by http://www.tux.org/lkml/#s8-8?  If
that does not fix it, I need your complete .config plus your
/proc/ksyms.

