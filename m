Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWFKFfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWFKFfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFKFfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:35:06 -0400
Received: from corky.net ([212.150.53.130]:17087 "EHLO zebday.corky.net")
	by vger.kernel.org with ESMTP id S932104AbWFKFfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 01:35:04 -0400
Message-ID: <448BAB7B.6020002@corky.net>
Date: Sun, 11 Jun 2006 06:34:51 +0100
From: Just Marc <marc@corky.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP on CorKy.NeT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>Well, it looks like I'm the only one in this world who's drive was
>fired this way... ;)  Note it's a combination of two issues: it's
>definitely a buggy firmware (or hardware) - it should not fire,
>no matter how you're hitting it from software - and the readahead+
>EIO logic.  So.. well, I don't want to try another drive really,
>but it *seems* like it will eventually "recover".  Not that it's
>possible still to watch a DVD with a single scratch (one unreadable
>block) anyway with current code (it will freeze and freeze and freeze
>again and again), but well, it's not really THAT critical.  My drive
>is already dead, nothing worse can happen to it anyway ;)

I'm pretty sure you're not the only one, I have had my CD/DVD drive *obsessively*
try to read from a bad CD/DVD (or just a badly scrached area on the disc),
bringing the system to an unusable state and not even stopping in reasonable time
(minutes, at least), I was forced to power cycle the laptop in all of these cases.

Marc

