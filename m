Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275352AbTHMUIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275363AbTHMUIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:08:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:65032 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S275352AbTHMUIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:08:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Catalin BOIE <util@deuroconsult.ro>, Lars Duesing <ld@stud.fh-muenchen.de>
Subject: Re: 2.6.0test3mm1 + gcc 3.2.3 | gcc3.3 compile error (Input/output error)
Date: Wed, 13 Aug 2003 23:08:03 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0308121603010.8716@hosting.rdsbv.ro> <1060694115.22608.3.camel@ws1.intern.stud.fh-muenchen.de> <Pine.LNX.4.56.0308121621280.8716@hosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.56.0308121621280.8716@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308132308.03220.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 16:22, Catalin BOIE wrote:
> > Hi Catalin,
> >
> > > arch/i386/kernel/built-in.o: could not read symbols: Input/output error
> > > make: *** [.tmp_vmlinux1] Error 1
> >
> > There it says :)
> > ld could not read data from harddisk - either it is full, or corrupted.
>
> I have space on disk.
> cat "arch/i386/kernel/built-in.o > /dev/null" works ok, without errors
> (dmesg).
>
> Other ideas?

strace ld invocation
--
vda
