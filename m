Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUEONFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUEONFx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 09:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUEONFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 09:05:53 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:37831 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262388AbUEONFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 09:05:09 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Justin Piszcz" <jpiszcz@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Date: Sat, 15 May 2004 15:06:20 +0200
User-Agent: KMail/1.5.3
Cc: apiszcz@solarrain.com
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com>
In-Reply-To: <BAY18-F105X7rz6AvEm0002622f@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151506.20765.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 of May 2004 14:20, Justin Piszcz wrote:
> The problem is the 2.6.6 kernel muxed my drive and when it fscked upon
> reboot it deleted /etc/mtab and lilo.conf!

What fs are you using?

> Luckily I restored them from a backup and now run 2.6.5 and it is working
> fine.
>
> Linux 2.6.6 is a nightmare.
>
> I am looking into the benchmark problem with 2.6.6 now.
>
> --- In linux-kernel@yahoogroups.com, "Justin Piszcz" <jpiszcz@h...> wrote:
> >Now whenever I reboot it says input/output errors when it tries to mount
> >the drive? I will look into this further.

This errors are HARMLESS and CAN'T corrupt your data.
Please see http://bugme.osdl.org/show_bug.cgi?id=2672 for description+fix.

Cheers,
Bartlomiej

