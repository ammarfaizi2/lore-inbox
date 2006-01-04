Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWADRvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWADRvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWADRvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:51:44 -0500
Received: from xenotime.net ([66.160.160.81]:30398 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030231AbWADRvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:51:44 -0500
Date: Wed, 4 Jan 2006 09:51:40 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.14.5 to 2.6.15 patch
In-Reply-To: <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0601040950530.19134@shark.he.net>
References: <200601041710.37648.nick@linicks.net>  <200601041728.52081.nick@linicks.net>
  <9a8748490601040940peb15b75n454e02a622f795e1@mail.gmail.com> 
 <200601041745.39180.nick@linicks.net> <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Jesper Juhl wrote:

> On 1/4/06, Nick Warne <nick@linicks.net> wrote:
> > On Wednesday 04 January 2006 17:40, Jesper Juhl wrote:
> >
> > > > I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5
> > >
> > > If you did that you did it wrong. The -stable patches are *not*
> > > incremental, they all apply to the base 2.6.x kernel.
> >
> > nick@linuxamd:kernel$ ls -lsa | grep patch
> >
> >    24 -rw-r--r--   1 nick users    20572 2005-11-11 06:07 patch-2.6.14.2
> >    48 -rw-r--r--   1 nick users    46260 2005-11-24 22:15 patch-2.6.14.3
> >    24 -rw-r--r--   1 nick users    22725 2005-12-15 00:27 patch-2.6.14.3-4
> >    20 -rw-r--r--   1 nick users    18651 2005-12-27 00:29 patch-2.6.14.4-5
> >
>
> $ ncftp ftp.kernel.org
> NcFTP 3.1.9 (Mar 24, 2005) by Mike Gleason (http://www.NcFTP.com/contact/).
> Connecting to 204.152.191.37...
> Welcome to ftp.kernel.org.
> Logging in...
> <-- snip -->
> ncftp / > cd /pub/linux/kernel/v2.6/
> Directory successfully changed.
> ncftp /pub/linux/kernel/v2.6 > ls -l patch-2.6.14.?.gz
> -rw-r--r--    1 536      536         2841   Nov  9 01:01   patch-2.6.14.1.gz
> -rw-r--r--    1 536      536         6566   Nov 11 06:07   patch-2.6.14.2.gz
> -rw-rw-r--    1 536      536        13849   Nov 24 22:15   patch-2.6.14.3.gz
> -rw-r--r--    1 536      536        21012   Dec 15 00:27   patch-2.6.14.4.gz
> -rw-r--r--    1 536      536        25943   Dec 27 00:29   patch-2.6.14.5.gz

but the incremental patches do appear to be in
  http://www.kernel.org/pub/linux/kernel/v2.6/incr/

who generates these?  are they automated?

-- 
~Randy
