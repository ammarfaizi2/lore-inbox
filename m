Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbUA1NCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265936AbUA1NCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:02:12 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:58893 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265934AbUA1NCJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:02:09 -0500
Date: Thu, 29 Jan 2004 00:02:07 +1100 (EST)
From: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Cursor disappears on console, no frame-buffer
In-Reply-To: <200401281356.52102.ender@debian.org>
Message-ID: <Pine.LNX.4.53.0401290000090.7071@tellurium.ssi.swin.edu.au>
References: <slrn-0.9.7.4-26788-30547-200401282138-tc@hexane.ssi.swin.edu.au>
 <200401281356.52102.ender@debian.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, David [iso-8859-15] Martínez Moreno wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> El Miércoles, 28 de Enero de 2004 11:46, Tim Connors escribió:
> > Recently, a few kernel revisions ago, I experimented with the
> > frame-buffer. I don't know what I broke, but with nothing frame-buffer
> > related in the kernel (It could have been broken for a long time, I
> > don't use the console that much, but it certainly worked at one
> > stage):
>
> 	Have you followed Dave's doc to console new style in 2.6?
>
> http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
>
> 	There you can find a lot of possible problems for an unexistent console.

Bugger. I forgot to mention the kernel version (although it is in the
dmesg output); realising full well this is a FAQ for 2.6.

2.4.23 originally, still a problem in 25-pre7.

I'll have to do some testing to find out how much earlier it is still
there.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
So there you have it, supplicant. The Europeans aren't morally superior
to you [USAnians] at all. Just intellectually.       -- The Usenet Oracle
