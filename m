Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267331AbUGNJC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267331AbUGNJC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUGNJC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:02:27 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:52708 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S267331AbUGNJCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:02:25 -0400
Date: Wed, 14 Jul 2004 11:02:08 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Hermann Gottschalk <hg@ostc.de>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: Strange Network behaviour
Message-ID: <20040714090208.GA2274@k3.hellgate.ch>
Mail-Followup-To: Hermann Gottschalk <hg@ostc.de>,
	bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <20040702153028.GD15170@ostc.de> <20040704164654.GA18688@outpost.ds9a.nl> <20040714080036.GC11178@ostc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714080036.GC11178@ostc.de>
X-Operating-System: Linux 2.6.7-bk20 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 10:00:36 +0200, Hermann Gottschalk wrote:
> OK, now after an "update" to 2.4.21-231 (SuSE 9.0) some similar
> Errors occur:
> 
> 1) The via-rhine IF isn't accessible anymore. It's up but doesn't work.
> 
> 2) We work with lvm and lvm-snapshots can't be removed anymore. I
>    get a segmentation fault.

Looks like you have more than one problem. The lvm related trace is
hardly due to via-rhine (and you need to send it through ksymoops
to get something useful).

If you set debug in via-rhine to 3, you'll get a more interesting
log. Does booting with noacpi help at all?

Roger
