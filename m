Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUEFNiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUEFNiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUEFNhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:37:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16067 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262109AbUEFNfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:35:09 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Date: Thu, 6 May 2004 15:33:59 +0200
User-Agent: KMail/1.5.3
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <200405051312.30626.dominik.karall@gmx.net> <200405060104.55340.bzolnier@elka.pw.edu.pl> <200405060955.57856.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200405060955.57856.norberto+linux-kernel@bensa.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405061533.59295.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 of May 2004 14:55, Norberto Bensa wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Making 4kb stacks default in -mm is very good idea so it will get
> > necessary testing and fixing before being integrated into mainline.
>
> Then let us test with _AND_ without 4KSTACKS.

You are free to remove this patch from your kernel. 8)

> I love the -mm three, but I use a nvidia GFX card too. Making 4KSTACkS
> permanent excludes me from more testing.

We currently need testing for 4KSTACKS.  Please also note that your testing
with binary modules loaded has limited value as you should always reproduce
problem w/o binary modules before reporting problem.

Regards,
Bartlomiej

