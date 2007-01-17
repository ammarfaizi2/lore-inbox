Return-Path: <linux-kernel-owner+w=401wt.eu-S932083AbXAQNh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbXAQNh1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 08:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbXAQNh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 08:37:27 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:50388 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083AbXAQNh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 08:37:26 -0500
Date: Wed, 17 Jan 2007 14:37:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tomasz Chmielewski <mangoo@wpkg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
In-Reply-To: <45AE1D65.4010804@wpkg.org>
Message-ID: <Pine.LNX.4.61.0701171435060.18562@yvahk01.tjqt.qr>
References: <45AE1D65.4010804@wpkg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The device is pretty small and has no keyboard, video card etc., so if it ever
> happens to break (can be a disk failure, but also operator who messed with
> startup scripts), it has to be opened (warranty!).
>
> These all unpleasant tasks could be avoided if it was possible to have a
> "fallback" device. For example, consider this hypothetical command line:
>
> root=/dev/sdb1,/dev/sda1

You should use initramfs to achieve that.


(Note that SD naming is anyway dynamic - if only one of USB or HDD
is plugged in, it will most likely become sda.)


	-`J'
-- 
