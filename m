Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVCUH3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVCUH3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 02:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVCUH3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 02:29:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9879 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261626AbVCUH3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 02:29:32 -0500
Date: Mon, 21 Mar 2005 08:29:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: viking <viking@flying-brick.caverock.net.nz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hiccups (was USB Mouse Hiccups)
In-Reply-To: <pan.2005.03.20.23.09.09.100611@brick.flying-brick.caverock.net.nz>
Message-ID: <Pine.LNX.4.61.0503210829120.7472@yvahk01.tjqt.qr>
References: <pan.2005.03.20.23.09.09.100611@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-meat-
>> I've also noted .10 is quicker off the blocks than 2.6.11 seems to be.
>
>Namely seems to happen around the times when I'm doing something like
>mounting devfs (takes nearly 30 secs), and when I'm accessing files from
>disc (bash$ less some-random-file.txt) - this can take about two seconds
>for Linux to actually notice I've done something. I've no idea where the
>error is here, either. i.e. is bash waiting around for me? is the
>filesystem code waiting for some reason? Is the kernel in a tailspin?
>[shrug]

Use sysrq+t and see where it "hangs".


Jan Engelhardt
-- 
