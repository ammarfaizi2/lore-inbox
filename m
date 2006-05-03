Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWEDG57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWEDG57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 02:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWEDG57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 02:57:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17424 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751411AbWEDG57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 02:57:59 -0400
Date: Wed, 3 May 2006 19:14:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jared Hulbert <jaredeh@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Advanced XIP File System
Message-ID: <20060503191422.GC4404@ucw.cz>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com> <200605030200.29141.arnd@arndb.de> <6934efce0605021859u55131e63xd8dab3d4396d7f56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6934efce0605021859u55131e63xd8dab3d4396d7f56@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Also ext2 doesn't do compression, and it doesn't let me 
> pick out
> specific pages in files to XIP or compress.

Patches for compressed ext2 exist; and it has many other nice uses,
too...

> >why? by how much?
> 
> Data packing:
> 1) When mkcramfs is writing files to the image it mixes 
> compress and
> XIP files.  XIP files are page aligned.  Compressed 
> files are not.  I
> think it was about 3.3% wasted I measured on an actual 
> production
> linux phone.

Which one, btw? I guess I need a new phone :-)
-- 
Thanks, Sharp!
