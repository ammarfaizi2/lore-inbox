Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWADRuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWADRuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWADRuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:50:32 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:62874 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030232AbWADRub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:50:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OLaHN4LZY06D5k4B4xljqcF2xLzA2kM9PlquPKkc4wLW2IuXohM6BZby+ZFap6zfG32nwPMlE60S/NbcDAVhHZ1jZbEd9A2E6xep6HMAxQ36zNZk1NIYV/ZYa1KrJtd9VIhWN8rtaBI+Su6zD4fJ6Ao1NAp/xaR1F9fheqa8c20=
Message-ID: <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com>
Date: Wed, 4 Jan 2006 18:50:29 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <200601041745.39180.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041710.37648.nick@linicks.net>
	 <200601041728.52081.nick@linicks.net>
	 <9a8748490601040940peb15b75n454e02a622f795e1@mail.gmail.com>
	 <200601041745.39180.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Nick Warne <nick@linicks.net> wrote:
> On Wednesday 04 January 2006 17:40, Jesper Juhl wrote:
>
> > > I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5
> >
> > If you did that you did it wrong. The -stable patches are *not*
> > incremental, they all apply to the base 2.6.x kernel.
>
> nick@linuxamd:kernel$ ls -lsa | grep patch
>
>    24 -rw-r--r--   1 nick users    20572 2005-11-11 06:07 patch-2.6.14.2
>    48 -rw-r--r--   1 nick users    46260 2005-11-24 22:15 patch-2.6.14.3
>    24 -rw-r--r--   1 nick users    22725 2005-12-15 00:27 patch-2.6.14.3-4
>    20 -rw-r--r--   1 nick users    18651 2005-12-27 00:29 patch-2.6.14.4-5
>

$ ncftp ftp.kernel.org
NcFTP 3.1.9 (Mar 24, 2005) by Mike Gleason (http://www.NcFTP.com/contact/).
Connecting to 204.152.191.37...
Welcome to ftp.kernel.org.
Logging in...
<-- snip -->
ncftp / > cd /pub/linux/kernel/v2.6/
Directory successfully changed.
ncftp /pub/linux/kernel/v2.6 > ls -l patch-2.6.14.?.gz
-rw-r--r--    1 536      536         2841   Nov  9 01:01   patch-2.6.14.1.gz
-rw-r--r--    1 536      536         6566   Nov 11 06:07   patch-2.6.14.2.gz
-rw-rw-r--    1 536      536        13849   Nov 24 22:15   patch-2.6.14.3.gz
-rw-r--r--    1 536      536        21012   Dec 15 00:27   patch-2.6.14.4.gz
-rw-r--r--    1 536      536        25943   Dec 27 00:29   patch-2.6.14.5.gz

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
