Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWC1Sns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWC1Sns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWC1Sns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:43:48 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:22225 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S932068AbWC1Snr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:43:47 -0500
Date: Tue, 28 Mar 2006 20:43:35 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Joseph Fannin <jfannin@gmail.com>
cc: Stas Sergeev <stsp@aknet.ru>, 7eggert@gmx.de, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
In-Reply-To: <20060328183140.GA21446@nineveh.rivenstone.net>
Message-ID: <Pine.LNX.4.58.0603282040480.2538@be1.lrz>
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it>
 <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it>
 <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru>
 <20060328183140.GA21446@nineveh.rivenstone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Joseph Fannin wrote:

>     I would think the ideal situation would be to make every ALSA
> device capable of acting as the console bell (defaulting to muted,
> like every other ALSA mixer control).  Then only pcspkr would be the
> odd case (though maybe a common one).
> 
>     I dunno if there's a reasonably easy way to do that (without
> changing every ALSA driver) though.

I think that should be done using a userspace input device if possible.
-- 
A man inserted an advertisement in the classified: Wife Wanted."
The next day he received a hundred letters. They all said the
same thing: "You can have mine."
