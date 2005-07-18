Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVGRA1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVGRA1J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 20:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVGRA1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 20:27:09 -0400
Received: from mx57.globo.com ([200.208.9.88]:35494 "EHLO mx57.globo.com")
	by vger.kernel.org with ESMTP id S261461AbVGRA1H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 20:27:07 -0400
Date: Sun, 17 Jul 2005 21:27:05 -0300
Message-ID: <428C48BA000CBFCB@riosf03.globoi.com>
In-Reply-To: <200507171016.37940.norbert@edusupport.nl>
From: porranenhuma@globo.com
Subject: Re: Kernel Panic: VFS cannot open a root device
To: "Norbert van Nobelen" <norbert@edusupport.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: GloboMail
X-Originating-IP: 200.141.234.234
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already done that things , and I still getting these errors ... I dont
no what to do , and I'm getting desesperated...

 '>'-- Mensagem Original --
 '>'From: Norbert van Nobelen <norbert@edusupport.nl>
 '>'To: "GlupFire" <porranenhuma@globo.com>
 '>'Subject: Re: Kernel Panic: VFS cannot open a root device
 '>'Date: Sun, 17 Jul 2005 10:16:37 +0000
 '>'
 '>'
 '>'You should compile in the filesystem (reiserfs?) into the kernel (*
instead
 '>'of 
 '>'M), or put the correct module in initrd (usually done by mkinitrd).

 '>'After that run lilo, and it should boot just fine.
 '>'
 '>'Norbert
 '>'
 '>'Op zaterdag 16 juli 2005 20:57, schreef u:
 '>'> > Hi , i have kernel 2.4.29 at slack 10.1 and when I upgrade my kernel
 '>'to
 '>'> > 2.6.11 I get these erros on booting
 '>'> >
 '>'> > VFS: Cannot open a root device "301" or unknow block
 '>'> > please append a correct "root" boot option
 '>'> > KERNEL PANIC :  not syncing; VFS; Unable to mount root fs on
 '>'> > unknown-block (3,1)
 '>'> >
 '>'> > I have compiled my kernel with my IDE support and also with my file
 '>'> > system support with built-in option.
 '>'> >
 '>'> > My LILO.CONF
 '>'> > image = /boot/vmlinuz-2.6.11
 '>'> > root = /dev/hda1
 '>'> > label = 2.6.11
 '>'> > initrd = /boot/initrd.gz
 '>'> > read-only
 '>'> >
 '>'> > I googled this problem, and I think is a kind of bug, and i tryed
to
 '>'> > patch the kernel with Alan Cox patch 2.6.11-ac7.bzip  and I get
these
 '>'::
 '>'> > bzip2 -dc /usr/src/patch-2.6.11.ac7.bzip | patch -p1 -s
 '>'> > 1 out of hunk FAILED --saving rejects to file Makefike.rej
 '>'> >
 '>'> > and I cat the file Makefile.rej
 '>'> >
 '>'> > ***************
 '>'> > *** 1,8 ****
 '>'> > VERSION = 2
 '>'> > PATCHLEVEL = 6
 '>'> > SUBLEVEL = 11
 '>'> > - EXTRAVERSION =
 '>'> > - NAME=Woozy Numbat
 '>'> >
 '>'> > # *DOCUMENTATION*
 '>'> > # To see a list of typical targets execute "make help"
 '>'> > --- 1,8 ----
 '>'> > VERSION = 2
 '>'> > PATCHLEVEL = 6
 '>'> > SUBLEVEL = 11
 '>'> > + EXTRAVERSION = ac7
 '>'> > + NAME=AC
 '>'> >
 '>'> > # *DOCUMENTATION*
 '>'> > # To see a list of typical targets execute "make help"
 '>'> >
 '>'> > I'm stuck! The patch dont work fine ( I think the patch is not installed
 '>'> > succesfully on my kernel )
 '>'> > I'm booting with my image of kernel 2.4.29..... i'm 5 days tryng
to solve
 '>'> > this problem ...
 '>'> > any kind of help is wellcome... sorry for my english.
 '>'>
 '>'> -
 '>'> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
 '>'in
 '>'> the body of a message to majordomo@vger.kernel.org
 '>'> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 '>'> Please read the FAQ at  http://www.tux.org/lkml/


