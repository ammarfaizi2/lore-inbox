Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130529AbQLEKd2>; Tue, 5 Dec 2000 05:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130613AbQLEKdH>; Tue, 5 Dec 2000 05:33:07 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:58898 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130529AbQLEKcr>; Tue, 5 Dec 2000 05:32:47 -0500
Date: Tue, 5 Dec 2000 05:02:48 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Athlon CPU
In-Reply-To: <200012050945.eB59jYu01739@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.30.0012050458100.620-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Lukasz Trabinski wrote:

>In article <Pine.LNX.4.30.0012042315410.620-100000@asdf.capslock.lan> you wrote:
>> ^^^^^^^^^^^^^^^^
>
>> You can't build a kernel with that compiler.  You _must_ use gcc
>> 2.91.66 or another compiler that can compile the kernel.  Red Hat
>> ships gcc 2.91.66 packaged as "kgcc" for kernel builds as do
>> other major vendors.
>
>Huh, no way, I have tried also with kgcc:

The kgcc compiler is merely gcc 2.91.66, and it most definitely
compiles the kernel correctly.  If yours is failing, then you are
doing something wrong or have the wrong version of something else
interfering, or perhaps some other problem.

Provide a larger screenshot wher it actually shows c ompiler
build lines, errors, etc..  Also check that you're using the
proper versions of stuff as listed in Changelog.

What specific kernel are you building again?  Is it stock or
patched?



----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------


#[Mike A. Harris bash tip #1 - separate history files per virtual console]
# Put the following at the bottom of your ~/.bash_profile
[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
tty |grep "^/dev/tty[0-9]" >& /dev/null && \
        export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
