Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTICVJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTICVJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:09:43 -0400
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:38528 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264399AbTICVJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:09:41 -0400
Subject: Re: devfs to be obsloted by udev?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg KH <greg@kroah.com>, Justin Cormack <justin@street-vision.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Sweetman <ed.sweetman@wmich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030903191701.GA12532@mars.ravnborg.org>
References: <3F54A4AC.1020709@wmich.edu>
	 <200309022219.02549.bzolnier@elka.pw.edu.pl>
	 <1062581929.30060.197.camel@lotte.street-vision.com>
	 <20030903184140.GA1651@kroah.com>
	 <20030903191701.GA12532@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1062623380.30752.217.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Sep 2003 14:09:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 12:17, Sam Ravnborg wrote:

> Can some one sched a bit more light on what is seeked to get it integrated
> in the build.

See my previous response to Greg.

The only outstanding build issue is that the userspace stuff gets
rebuilt unconditionally on every make, and I don't know why.  You're
welcome to clone the repo at http://klibc.bkbits.net:8080/2.5-klibc and
figure it out.

>  Kai G. did a big update in this area some time ago -
> but maybe more is needed?

The build integration in the repo above is based on Kai's changes,
forward ported from 2.5.60 or so.  You are more than welcome to prettify
the hacking I had to do to get it working.

	<b

