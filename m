Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUCSXyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUCSXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:54:54 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16815 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263173AbUCSXys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:54:48 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [PATCH] barrier patch set
Date: Sat, 20 Mar 2004 01:02:39 +0100
User-Agent: KMail/1.5.3
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com> <20040319230136.GC7161@merlin.emma.line.org>
In-Reply-To: <20040319230136.GC7161@merlin.emma.line.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403200102.39716.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 of March 2004 00:01, Matthias Andree wrote:
> On Fri, 19 Mar 2004, Jeff Garzik wrote:
> > - issue set-features command to get flush-cache into proper state
> > (enabled or disabled, as the user desires), if identify-device word 86
> > indicates it is not already in the state you seek.
>
> BTW, speaking of identify-device, hdparm -i (which uses
> HDIO_GET_IDENTITY) always returns "WriteCache=enabled" while hdparm -I
> that uses HDIO_DRIVE_CMD with WIN_PIDENTIFY reports the "correct" state
> that I've previously set with -W0. This is an i386 machine w/ 2.6.5-rc1.
>
> Is HDIO_GET_IDENTITY working correctly?

There were reports that on some drives you can't disable write cache
and even (?) that some drives lie (WC still enabled but marked as disabled).

Regards,
Bartlomiej

