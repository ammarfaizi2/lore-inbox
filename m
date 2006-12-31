Return-Path: <linux-kernel-owner+w=401wt.eu-S1030428AbWLaS13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWLaS13 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 13:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWLaS13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 13:27:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:41157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030428AbWLaS12 (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 13:27:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EgLgWGoZBUhcd382ppRk6lNPkuz/mComHZw16PDjPyBg+9uS799GWQpSX0aHECF0L718kyGXWr1TX9dx8yVwFPy2p1+77wzc6MzQOJYv1AEcfztz3uPxQ5mPN66J+cXLKCN7ZgoUhbHpZNLf6KWqOBy9yR9PDEycQJYQ8kkhkl0=
Message-ID: <9c21eeae0612311027p17737cc0q765aca18fe22fd38@mail.gmail.com>
Date: Sun, 31 Dec 2006 10:27:26 -0800
From: "David Brown" <dmlb2000@gmail.com>
To: "Robin Cook" <rcook@wyrms.net>
Subject: Re: compile failure on 2.6.19
Cc: Linux-kernel@vger.kernel.org
In-Reply-To: <1167585932.3730.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1167585932.3730.9.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/06, Robin Cook <rcook@wyrms.net> wrote:
> I am getting this error when I try to compile 2.6.19 and 2.6.19.1.
>
> I ran make mrproper and make menuconfig then ran make and got the below
> error.
>
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf -s arch/i386/Kconfig
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
> /bin/sh: -c: line 0: syntax error near unexpected token `('
> /bin/sh: -c: line 0: `set -e; echo '  CHK
> include/linux/utsrelease.h'; mkdir -p include/linux/;     if [ `echo -n
> "2.6.19.1 .file null .ident
> GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ];
> then echo '"2.6.19.1 .file null .ident
> GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits" exceeds 64
> characters' >&2; exit 1; fi; (echo \#define UTS_RELEASE \"2.6.19.1 .file
> null .ident GCC:(GNU)4.1.1 .section .note.GNU-stack,,@progbits\";) <
> include/config/kernel.release > include/linux/utsrelease.h.tmp; if [ -r
> include/linux/utsrelease.h ] && cmp -s include/linux/utsrelease.h
> include/linux/utsrelease.h.tmp; then rm -f
> include/linux/utsrelease.h.tmp; else echo '  UPD
> include/linux/utsrelease.h'; mv -f include/linux/utsrelease.h.tmp
> include/linux/utsrelease.h; fi'
> make: *** [include/linux/utsrelease.h] Error 2

I'd check /dev/null and make sure it's not a regular file this
happened to me a while back

- David Brown
