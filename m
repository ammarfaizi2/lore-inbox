Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUE1OSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUE1OSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUE1OSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:18:43 -0400
Received: from mail.rdsor.ro ([193.231.238.10]:7301 "HELO mail.rdsor.ro")
	by vger.kernel.org with SMTP id S263184AbUE1OSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:18:38 -0400
From: Balint Cristian <rezso@rdsor.ro>
Organization: Home
To: Thomas Steudten <alpha@steudten.com>
Subject: Re: Kernel crash/ oops >= 2.6.5 with gcc 3.4.0 on alpha
Date: Fri, 28 May 2004 17:19:20 -0400
User-Agent: KMail/1.6.2
Cc: Herbert Poetzl <herbert@13thfloor.at>, linux-admin@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
References: <40B726C0.5030400@steudten.com> <20040528123758.GE19544@MAIL.13thfloor.at> <40B74779.40406@steudten.com>
In-Reply-To: <40B74779.40406@steudten.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405281719.20593.rezso@rdsor.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 May 2004 10:06, Thomas Steudten wrote:
> I upgrade the binutils from 2.15.90 to 2.15.91, but the same
> message appears:
> 
> gcc -Wp,-MD,fs/cifs/.cifsfs.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall 
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mno-fp-regs 
> -ffixed-8 -msmall-data -mcpu=pca56 -Wa,-mev6 -O2 -fomit-frame-pointer 
> -Wdeclaration-after-statement   -DMODULE -DKBUILD_BASENAME=cifsfs -DKBUILD_MODNAME=cifs -c -o 
> fs/cifs/.tmp_cifsfs.o fs/cifs/cifsfs.c
> {standard input}: Assembler messages:
> {standard input}:7: Warning: setting incorrect section attributes for .got
>
Hi  !

I got same error with 2.6.7-rc1 !

I tryed 2 days ago with FC2 3.3.3-7 gcc and very latest CVS binutils.
I tryed with older 3 variants of binutils, i suspect gcc rather than binutils or else.
	The ony what i dont tryed is older gcc.

 
> 
> 
> > hmm, did you update the binutils too?
> > (if not, I'd try that)
> > 
> 
