Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUI3F0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUI3F0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268746AbUI3F0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:26:31 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:51168 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S268752AbUI3F02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:26:28 -0400
Subject: Re: Linux 2.6.9-rc3
From: Marcel Holtmann <marcel@holtmann.org>
To: gene.heskett@verizon.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tom Duffy <Tom.Duffy@sun.com>
In-Reply-To: <200409300120.05524.gene.heskett@verizon.net>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
	 <415B93AC.3010502@sun.com>  <200409300120.05524.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1096521895.5181.5.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 07:24:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

> >> Ok, this 2.6.9 cycle is getting too long, but here's a -rc3 and
> >> hopefully we're getting there now.
> >
> >   CC [M]  drivers/isdn/capi/capi.o
> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function
> >`handle_minor_send':
> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:538:
> >warning: cast from pointer to integer of different size
> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function
> >`capi_recv_message':
> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
> >error: `tty' undeclared (first use in this function)
> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
> >error: (Each undeclared identifier is reported only once
> >/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
> >error: for each function it appears in.)
> >make[4]: *** [drivers/isdn/capi/capi.o] Error 1
> >make[3]: *** [drivers/isdn/capi] Error 2
> >make[2]: *** [drivers/isdn] Error 2
> >make[1]: *** [drivers] Error 2
> >make: *** [_all] Error 2
> >-
> 
> Please start from the 2.6.8.tar.gz tarball, Tom.  This looks like you 
> may started from the 2.6.8.1.tar.gz.

no. It is a problem of the TTY locking fixes from Alan.

Regards

Marcel


