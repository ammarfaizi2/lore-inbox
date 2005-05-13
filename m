Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVEMPPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVEMPPC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVEMPPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:15:02 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:39333 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262396AbVEMPOy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:14:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EgYMtfNQnMGUhuJaKLAsGI1fj1oNfQTGLKDseA0qHF1EmPPHfejcE74qA7oOeq3uB7lfXxtyVKlx0j7TMyiuUrcRA8VQlZyqBLmZdXRz+//c8dIeZnc2V3zt8PCeAPmWRWbWC17Sa46caPjJHv9rrJgYESOXZHcfnxLnwCAuzg0=
Message-ID: <40a4ed59050513081457b3c67b@mail.gmail.com>
Date: Fri, 13 May 2005 17:14:54 +0200
From: Zeno Davatz <zdavatz@gmail.com>
Reply-To: Zeno Davatz <zdavatz@gmail.com>
To: gentoo-user@lists.gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: [gentoo-user] Fwd: VFS does not find /dev/sda3 (8,3), Kernel Panic
In-Reply-To: <200505131340.57108.ext-dirk.heinrichs@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <40a4ed5905051301126a0fc8a3@mail.gmail.com>
	 <200505131118.28631.ext-dirk.heinrichs@nokia.com>
	 <40a4ed5905051303034a2c441a@mail.gmail.com>
	 <200505131340.57108.ext-dirk.heinrichs@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks for all your help, I found out: it was a faulty (new !! SATA disk).

Thanks again
Zeno

On 5/13/05, Dirk Heinrichs <ext-dirk.heinrichs@nokia.com> wrote:
> Am Freitag, 13. Mai 2005 12:03 schrieb ext Zeno Davatz:
> > Yes, sorry, your are right. To much configuring in my brain.
> >
> > Check the new config. I suppose I only need the Intel PII/ICH SATA
> > support (as my lspci tells me).
> >
> > But I get the same result; a Kernel Panic VFS not found (8,3)... but
> > my HDD is on /dev/sda3.
> >
> > Is there any why I can get more detailed info out of my kernel-boot
> > (except from my screen)?
> 
> In "make menuconfig", the help text for this driver says:
> 
> "This option enables support for ICH5 Serial ATA.
> If PATA support was enabled previously, this enables
> support for select Intel PIIX/ICH PATA host controllers."
> 
> Maybe you should switch off PATA first.
> 
> HTH...
> 
>         Dirk
> --
> Dirk Heinrichs          | Tel:  +49 (0)162 234 3408
> Configuration Manager   | Fax:  +49 (0)211 47068 111
> Capgemini Deutschland   | Mail: dirk.heinrichs@capgemini.com
> Hambornerstraße 55      | Web:  http://www.capgemini.com
> D-40472 Düsseldorf      | ICQ#: 110037733
> GPG Public Key C2E467BB | Keyserver: www.keyserver.net
> 
> 
>
