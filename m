Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132952AbRAKS5d>; Thu, 11 Jan 2001 13:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133001AbRAKS5N>; Thu, 11 Jan 2001 13:57:13 -0500
Received: from wg.redhat.de ([193.103.254.4]:61729 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S132952AbRAKS5K>;
	Thu, 11 Jan 2001 13:57:10 -0500
Date: Thu, 11 Jan 2001 19:57:09 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: Benson Chow <blc@q.dyndns.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: `rmdir .` doesn't work in 2.4
In-Reply-To: <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org>
Message-ID: <Pine.LNX.4.30.0101111956190.27413-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Benson Chow wrote:

> Not very portable at all...
>
> hpux = HP/UX 10.2
>
> hpux:~/foo$ rmdir .
> rmdir: cannot remove .. or .

Same on FreeBSD, by the way

bash-2.04# uname -a
FreeBSD freebsd.redhat.de 5.0-20001112-CURRENT FreeBSD 5.0-20001112-CURRENT
#0: Sun Nov 12 14:04:55 GMT 2000 root@usw2.freebsd.org:/usr/src/sys/compile/BERO  i386
bash-2.04# mkdir test
bash-2.04# cd test
bash-2.04# rmdir .
rmdir: .: Invalid argument

LLaP
bero


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
