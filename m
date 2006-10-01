Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWJATKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWJATKd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWJATKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:10:33 -0400
Received: from mail2.genealogia.fi ([194.100.116.229]:54462 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP id S932189AbWJATKc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:10:32 -0400
Date: Sun, 1 Oct 2006 12:08:52 -0700
From: Jouni Malinen <jouni.malinen@genealogia.fi>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: jt@hpl.hp.com, "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Message-ID: <20061001190852.GR6121@jm.kir.nu>
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com> <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.4 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 12:04:31AM +0200, Alessandro Suardi wrote:

> So I guess there's an actual bug that doesn't depend on the
> wireless-tools. Or maybe it's wpa_supplicant that has to be
> upgraded ?
> 
> [asuardi@sandman ~]$ rpm -q wpa_supplicant
> wpa_supplicant-0.4.8-10.fc5

2006-05-06 - v0.4.9
 * driver_wext: added support for WE-21 change to SSID configuration

I.e., not really a "bug", but an unfortunate result of making WLAN
drivers use one part of WE consistently..

-- 
Jouni Malinen                                            PGP id EFC895FA
