Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267328AbUHTODC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267328AbUHTODC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUHTODC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:03:02 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:1212 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S267328AbUHTOCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:02:54 -0400
Date: Fri, 20 Aug 2004 16:02:50 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jan Spitalnik <jan@spitalnik.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1 slews system clock
In-Reply-To: <200408201527.07126.jan@spitalnik.net>
Message-ID: <Pine.LNX.4.53.0408201601200.12519@gockel.physik3.uni-rostock.de>
References: <200408201527.07126.jan@spitalnik.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Jan Spitalnik wrote:

> after updating kernel to 2.6.8.1 the system clock slews by 1 second every 10
> seconds into future. I tried turning off ACPI, but that had no effect.
> 
> root@largo:~# ntpdate tik.cesnet.cz;sleep 10;ntpdate tik.cesnet.cz
> 20 Aug 13:55:01 ntpdate[5315]: step time server 195.113.144.201 offset
> -24.488611 sec
> 20 Aug 13:55:13 ntpdate[5321]: step time server 195.113.144.201 offset
> -1.042110 sec
> 
> on second machine the effect is opposite, ie the clock slews backwards.
> Any ideas?

Which was the last kernel that worked?
