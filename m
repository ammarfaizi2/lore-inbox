Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946145AbWJTNS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946145AbWJTNS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946191AbWJTNS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:18:27 -0400
Received: from [81.2.110.250] ([81.2.110.250]:11984 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1946145AbWJTNS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:18:27 -0400
Subject: Re: [PATCH] 2.6.19.-rc2-mm2 compile fix for sclp_tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1161348812.3135.8.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1161348812.3135.8.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Oct 2006 14:21:01 +0100
Message-Id: <1161350462.26440.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-20 am 14:53 +0200, ysgrifennodd Martin Peschke:
> Extern declaration of tty_std_termios in sclp_tty was a hack
> which is obsolete.
> 
>   CC      drivers/s390/char/sclp_tty.o
> drivers/s390/char/sclp_tty.c:63: error: conflicting types for 'tty_std_termios'
> include/linux/tty.h:261: error: previous declaration of 'tty_std_termios' was here
> drivers/s390/char/sclp_tty.c: In function 'sclp_tty_init':
> drivers/s390/char/sclp_tty.c:790: error: incompatible types in assignment
> make[2]: *** [drivers/s390/char/sclp_tty.o] Error 1
> make[1]: *** [drivers/s390/char] Error 2
> make: *** [drivers/s390] Error 2
> Kernel compilation...FAILED
> 
> Signed-off-by: Martin Peschke <mp3@de.ibm.com> 
> Acked-by: Peter Oberparleiter <oberpar@de.ibm.com>

Acked-by: Alan Cox <alan@redhat.com>

