Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261359AbSIZPEk>; Thu, 26 Sep 2002 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbSIZPEk>; Thu, 26 Sep 2002 11:04:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:50848 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261359AbSIZPEj>; Thu, 26 Sep 2002 11:04:39 -0400
Date: Thu, 26 Sep 2002 12:09:44 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Daniel Pittman <daniel@rimspace.net>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
In-Reply-To: <87k7l95f5a.fsf@enki.rimspace.net>
Message-ID: <Pine.LNX.4.44L.0209261208590.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Daniel Pittman wrote:

> > read:write, ie no read preference. A silly value of 0 would give you
> > write preference, always.

> How much is it going to hurt a filesystem like ext[23] if that value is
> set to zero while doing large streaming writes -- something like
> (almost) uncompressed video at ten to twenty meg a second, for
> gigabytes?

It depends, if you've got 2 video streams to the same
filesystem and one needs to read a block bitmap in order
to allocate more disk blocks you lose...

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

