Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWG2IET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWG2IET (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWG2IES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:04:18 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:19672 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932645AbWG2IEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:04:16 -0400
Date: Sat, 29 Jul 2006 10:02:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ProfiHost - Stefan Priebe <s.priebe@profihost.com>
cc: Nathan Scott <nathans@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
In-Reply-To: <44CB158B.1050209@profihost.com>
Message-ID: <Pine.LNX.4.61.0607291001370.20234@yvahk01.tjqt.qr>
References: <44C8A5F1.7060604@profihost.com> <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr>
 <20060729075054.B2222647@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0607290953480.20234@yvahk01.tjqt.qr> <44CB158B.1050209@profihost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This only happens, if your partition is the root partition of the whole system
>
It is..

> and it is mounted read only on system start up.
>
It is...

> The pre barrier check for normal mount works without any problems.
>
Dang, I forgot that hda is a little older and does not support barriers. 
/me slaps himself.



Jan Engelhardt
-- 
