Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBJCow>; Fri, 9 Feb 2001 21:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129400AbRBJCoc>; Fri, 9 Feb 2001 21:44:32 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:30475 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129258AbRBJCoY>;
	Fri, 9 Feb 2001 21:44:24 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jean-Luc Fontaine <jfontain@winealley.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1: unresolved symbol with nfsd as a module 
In-Reply-To: Your message of "Fri, 09 Feb 2001 17:56:37 BST."
             <01020917563700.00917@suzuki.winealley.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Feb 2001 13:44:05 +1100
Message-ID: <17635.981773045@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001 17:56:37 +0100, 
Jean-Luc Fontaine <jfontain@winealley.com> wrote:
># insmod ./kernel/fs/nfsd/nfsd.o
>./kernel/fs/nfsd/nfsd.o: unresolved symbol nfsd_linkage
># fgrep nfsd System.map 
>c01f3f60 ? __kstrtab_nfsd_linkage
>c01f8b90 ? __ksymtab_nfsd_linkage
>c01fedc8 D nfsd_linkage

http://www.tux.org/lkml/#s8-8

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
