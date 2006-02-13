Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWBMKk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWBMKk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWBMKk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:40:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932067AbWBMKkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:40:25 -0500
Date: Mon, 13 Feb 2006 02:39:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avuton Olrich <avuton@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060213023925.2b950eea.akpm@osdl.org>
In-Reply-To: <3aa654a40602130231p1c476e99paa986fa198951839@mail.gmail.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<3aa654a40602130231p1c476e99paa986fa198951839@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich <avuton@gmail.com> wrote:
>
> On 2/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Ok,
> >  it is out there (or in the process of getting mirrored out), so go wild.
> 
> Hello, I appear to be getting the same issue I had back here:
> http://lkml.org/lkml/2006/2/1/121
> 
> A fix appeared a few messages later:
> http://lkml.org/lkml/2006/2/1/129
> http://lkml.org/lkml/2006/2/1/131
> 
> I'm obviously unsure if these were correct fixes or what but they did
> fix it, and they were or are in -mm afaik.
> 
> I am not _sure_ this is the same bug, but the panic messages rings a
> bell (sorry, I already deleted the old pictures as it appeared to be
> taken care of in -mm).
> 
> In the case that it's not the same issue here's a new snapshot of the
> kernel panic:
> http://68.111.224.150:8080/~sbh/P1010029.JPG
> ..and the config:
> http://68.111.224.150:8080/~sbh/micromachine.config
> 
> If an essential part of the panic is missing please let me know and I
> will try to remember how I got it shrunk down better last time.
> 

That looks like a different cpufreq bug.  Unfortunately the critical first
few lines have scrolled away.  Please boot with `vga=extended' so we get to
see them.

