Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTKBQlC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 11:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTKBQlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 11:41:02 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24279 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261755AbTKBQk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 11:40:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: uaca@alumni.uv.es
Subject: Re: 2.6.0-test9: BUG alim15x3.c
Date: Sun, 2 Nov 2003 17:46:00 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20031102150911.GB14148@pusa.informat.uv.es> <200311021645.54838.bzolnier@elka.pw.edu.pl> <20031102155423.GA15847@pusa.informat.uv.es>
In-Reply-To: <20031102155423.GA15847@pusa.informat.uv.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311021746.00852.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try "hda=remap" and "hda=remap63" and please don't ask me why it is not
autodetected (not my fault)...

On Sunday 02 of November 2003 16:54, uaca@alumni.uv.es wrote:
> Hi Bartlemiej!
>
> On Sun, Nov 02, 2003 at 04:45:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 02 of November 2003 16:09, uaca@alumni.uv.es wrote:
>
> [...]
>
> > Does it recognize drives correctly?
>
> I will double check that
>
> > Does ALI driver oops?
>
> no
>
> > Do you have support for your filesystem compiled-in (not as module).
>
> yes
>
> > Have you tried passing "root=/dev/hda" (or similar) boot parameter?
>
> yes, and I pass it right :-)
>
> when the systems boot, at the partition table check
> it prints
>
> "unknown partition table"
>
> Thanks
>
> 	Ulisses
>
>                 Debian GNU/Linux: a dream come true
> ---------------------------------------------------------------------------
>-- "Computers are useless. They can only give answers."            Pablo
> Picasso
>
> --->	Visita http://www.valux.org/ para saber acerca de la	<---
> --->	Asociación Valenciana de Usuarios de Linux		<---

