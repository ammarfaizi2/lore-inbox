Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSCXSCu>; Sun, 24 Mar 2002 13:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311642AbSCXSCb>; Sun, 24 Mar 2002 13:02:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30738 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311641AbSCXSCR>;
	Sun, 24 Mar 2002 13:02:17 -0500
Date: Sun, 24 Mar 2002 15:01:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, andreas <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <200203241757.SAA20700@piggy.rz.tu-ilmenau.de>
Message-ID: <Pine.LNX.4.44L.0203241501120.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Christian Bornträger wrote:
> Rik van Riel wrote:
> > On Sun, 24 Mar 2002, Roy Sigurd Karlsbakk wrote:
> > > Would it hard to do some memory allocation statistics, so if some
> > > process at one point (as rsync did) goes crazy eating all memory, that
> > > would be detected?
> >
> > No.  What I doubt however is whether it would be worth it,
> > since most machines never run OOM.
>
> Well, I think could be worth in terms of security, because a local user
> could use a bad memory-eating program to produce an Denial of Service of
> other processes.

If you don't trust your users you should do some editing
of /etc/security/limits.conf instead of relying on the
safety net in the kernel.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

