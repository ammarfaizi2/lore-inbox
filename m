Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTLXCia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTLXCia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:38:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:53914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263518AbTLXCiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:38:21 -0500
Date: Tue, 23 Dec 2003 18:38:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: greg@kroah.com, ULMO@Q.NET, linux-kernel@vger.kernel.org
Subject: Re: DevFS vs. udev
Message-Id: <20031223183820.5b297c50.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0312240938450.890-100000@wombat.indigo.net.au>
References: <20031223215910.GA15946@kroah.com>
	<Pine.LNX.4.33.0312240938450.890-100000@wombat.indigo.net.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:
>
> However, if Andrew wants it gone from the kernel there is no point.

I do not.  devfs shall remain in 2.6 and shall continue to be supported.

Richard has disappeared but Andrey Borzenkov understands devfs well and
performed valuable work on it during 2.5 development.


Nor would I recommend that devfs be removed early from 2.7.x.  We should
wait until the proposed udev/sysfs solutions have matured in 2.6 and have
proven themselves in the field.  Only then will we be in a position to
confirm that devfs can be removed without causing some people unacceptable
levels of grief.    There is no rush.


And yes, there are architectural/cleanliness issues with devfs.  In 2.5
Adam Richter totally reinventing devfs's internals, basing it around the
ramfs infrastructure.  If we elect to retain devfs in 2.8 then that effort
should be resurrected.


Now would be a good time for someone to feed the whole thing through indent
though.

