Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWFYLhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWFYLhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWFYLhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:37:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932380AbWFYLhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:37:09 -0400
Date: Sun, 25 Jun 2006 04:37:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Christian Lohmaier <lohmaier@gmx.de>
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
 atip wiith cdrecord
Message-Id: <20060625043702.e7e2d20f.akpm@osdl.org>
In-Reply-To: <1151233643.4940.13.camel@laptopd505.fenrus.org>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
	<20060624144739.78bde590.akpm@osdl.org>
	<1151233643.4940.13.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 13:07:23 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Sat, 2006-06-24 at 14:47 -0700, Andrew Morton wrote:
> > > I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.
> 
> 
> one issue is that it's a lot better to use --dev=/dev/hda (or whatever
> your cdrom device is.. usually even /dev/cdrom or /dev/cdwriter will
> work, depends on your distro)... that is what most people use and that
> is the interface that's actively supported and debugged...

cc added.
