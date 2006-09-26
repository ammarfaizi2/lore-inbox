Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWIZR3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWIZR3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWIZR3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:29:40 -0400
Received: from mx.pathscale.com ([64.160.42.68]:25520 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932166AbWIZR3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:29:39 -0400
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
	pmops->{prepare,enter,finish} support (aka "platform mode"))
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <1159292646.11049.273.camel@localhost.localdomain>
References: <20060925071338.GD9869@suse.de>
	 <1159220043.12814.30.camel@nigel.suspend2.net>
	 <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz>
	 <20060925160648.de96b6fa.akpm@osdl.org>  <20060925232151.GA1896@elf.ucw.cz>
	 <1159289108.9652.10.camel@chalcedony.pathscale.com>
	 <1159292646.11049.273.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 10:29:38 -0700
Message-Id: <1159291778.9652.23.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 18:44 +0100, Alan Cox wrote:
> Ar Maw, 2006-09-26 am 09:45 -0700, ysgrifennodd Bryan O'Sullivan:
> > 16 seconds doing things to devices
> 
> Flushing the cache of a busy disk is 7 seconds a disk just to begin
> with.

This is an idle machine whose only activity is to have woken up from an
earlier swsusp.  If I scribble on the disk a lot, it increases the
amount of time that swsusp takes, but only by a handful of seconds
(about the 7 you indicate, depending on the amount of dirty data).

	<b

