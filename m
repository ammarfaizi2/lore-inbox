Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbTFERfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 13:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264766AbTFERfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 13:35:01 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27356 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264779AbTFERe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 13:34:59 -0400
Date: Thu, 5 Jun 2003 19:47:35 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Julien Oster <lkml@mf.frodoid.org>
cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: capacity in 2.5.70-mm3
In-Reply-To: <frodoid.frodo.87y90g8lxm.fsf@usenet.frodoid.org>
Message-ID: <Pine.SOL.4.30.0306051944070.21862-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already fixed in 2.5-bk.
I will make 2.4 patch when I have time  (if nobody backports it first).
--
Bartlomiej

On Thu, 5 Jun 2003, Julien Oster wrote:

> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:
>
> Hello,
>
> >> capacity  capacity  capacity  driver  identify  media  model  settings
> >> Multiplay capacity files. Funny :)
>
> > Can reproduce it on my laptop with 2.5.70-mm3 and my server with
> > 2.5.70-bk8. Both have an ATAPI DVD attached to /dev/hdc.
>
> Can also reproduce it on 2.4.21-rc1, on all my IDE devices: hda, hdc,
> hdg. The first two are harddrives, the last one's an ATAPI CD writer,
> so the device type doesn't seem to matter:
>
> /proc/ide# ls hd?
> hda:
> cache     capacity  geometry  media  settings          smart_values
> capacity  driver    identify  model  smart_thresholds
>
> hdc:
> cache     capacity  geometry  media  settings          smart_values
> capacity  driver    identify  model  smart_thresholds
>
> hdg:
> capacity  capacity  driver  identify  media  model  settings
>
> Julien

