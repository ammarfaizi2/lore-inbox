Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132004AbRAaPCW>; Wed, 31 Jan 2001 10:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRAaPCC>; Wed, 31 Jan 2001 10:02:02 -0500
Received: from [216.151.155.116] ([216.151.155.116]:28435 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S132121AbRAaPBy>; Wed, 31 Jan 2001 10:01:54 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built.
In-Reply-To: <Pine.LNX.3.95.1010131093940.13598C-200000@chaos.analogic.com>
From: Doug McNaught <doug@wireboard.com>
Date: 31 Jan 2001 10:01:13 -0500
In-Reply-To: "Richard B. Johnson"'s message of "Wed, 31 Jan 2001 09:42:20 -0500 (EST)"
Message-ID: <m3d7d3lq9y.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> See attached. "Just because you can see the candy doesn't mean
> they'll let you have any...."

[output of README when you connect:]

>  Please note that the directory structure on ftp.gnu.org was redisorganzied
>  fairly recently, such that there is a directory for each program.  One side
>  effect of this is that if you cd into the gnu directory, and do
>  > ls emacs*
>  you will get a list of all the files in the emacs directory, but it will not
>  be obvious from the ls output that you have to `cd emacs' before you can
>  download those files.

Now,

> ftp> cd gnu
> ftp> ls mak*
> 200 PORT command successful.
> 150 Opening ASCII mode data connection for file list.
> -rw-r--r--   1 ftp      ftp          1095 Jul 14  1997 makeinfo.README
> 
> make:
> -rw-r--r--   1 ftp      ftp         27010 Sep 23  1989 make-3.55-3.56.diff.gz
[...]
> -rw-r--r--   1 ftp      ftp       1030393 Jun 24  2000 make-3.79.1.tar.gz
> -rw-r--r--   1 ftp      ftp        959005 Apr 11  2000 make-3.79.tar.gz
> 226 Transfer complete.
> ftp> bin
> 200 Type set to I.
> ftp> get make-3.79.1.tar.gz
> local: make-3.79.1.tar.gz remote: make-3.79.1.tar.gz
> 200 PORT command successful.
> 550 make-3.79.1.tar.gz: No such file or directory

Duh.

Read the README next time; that's what it's there for.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
