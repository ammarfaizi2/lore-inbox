Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUCSNT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUCSNT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:19:58 -0500
Received: from ncircle.nullnet.fi ([81.17.200.207]:51843 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262986AbUCSNT4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:19:56 -0500
Message-ID: <20809.194.237.142.13.1079702394.squirrel@ncircle.nullnet.fi>
In-Reply-To: <000901c40d25$0aab8360$1530a8c0@HUSH>
References: <000901c40d25$0aab8360$1530a8c0@HUSH>
Date: Fri, 19 Mar 2004 15:19:54 +0200 (EET)
Subject: Re: Hightpoint chipsets
From: "Tomi Orava" <tomimo+linux-kernel@ncircle.nullnet.fi>
To: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What's the current status of Highpoint RAID drivers, for both 2.4 and 2.6?
>
> I was using a 2.4 kernel just fine with my HP474 PCI card. I know some
> people had lots of DMA issues with it (I had them as well for some time).
> The thing is, inmediately after I plugged a new USB UPS (to be specific, a
> MGE Premium 800) I started to see those problems.

HPT374-ide chip seems to work OK only after applying the patch
Andre Hedrick sent a month ago (and a newer version today, it seems).
Without that patch HPT374 support is very flaky in a host with
heavy I/O. I have tested the first version of the above mentioned
patch for a couple of weeks without problems (mostly 2.4.25+patch kernel).

Regards,
Tomi Orava


