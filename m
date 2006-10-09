Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWJIHOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWJIHOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWJIHOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:14:32 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:12498 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932262AbWJIHOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:14:31 -0400
Date: Mon, 9 Oct 2006 09:12:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mike Frysinger <vapier@gentoo.org>
cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] pull in linux/types.h in linux/nbd.h
In-Reply-To: <200610082012.27879.vapier@gentoo.org>
Message-ID: <Pine.LNX.4.61.0610090912030.12485@yvahk01.tjqt.qr>
References: <200610082012.27879.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>the nbd header uses __be32 and such types but doesnt actually include the 
>header that defines these things (linux/types.h); so lets include it
>-mike

Hm, <linux/cdev.h> uses struct kobject and should therefore include 
<linux/kobejct.h>, can  you make a patch for that too? Thanks.


	-`J'
-- 
