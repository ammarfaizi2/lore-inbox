Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285121AbRLFLqS>; Thu, 6 Dec 2001 06:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285122AbRLFLqJ>; Thu, 6 Dec 2001 06:46:09 -0500
Received: from mustard.heime.net ([194.234.65.222]:54726 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S285121AbRLFLp4>; Thu, 6 Dec 2001 06:45:56 -0500
Date: Thu, 6 Dec 2001 12:45:23 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: James Stevenson <mail-lists@stev.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <008b01c17dce$d96b08d0$0801a8c0@Stev.org>
Message-ID: <Pine.LNX.4.30.0112061232010.15030-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > mkfs /dev/hdb1
> > dd if=/dev/zero of=some-file bs=x count=x
> >
> > What can fragment this file????
>  say you wanna write a 500MB file
> on a disk with plenty of space.
>
> but when you create the file it happens to
> create it in a place that only a 50MB file can
> fit because there is another file on the disk in that
> position. after 50MB is created then you have to put the rest file
> elsewhere thus you now have a fragmented file.

er...

take a look above

mkfs /dev/hdb1
(mount /dev/hdb1 /some/dir)
dd if=/dev/zero of=/some/dir/file ...

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


