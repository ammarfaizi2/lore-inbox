Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWHaNKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWHaNKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHaNKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:10:05 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:48059 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932198AbWHaNKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:10:04 -0400
Date: Thu, 31 Aug 2006 15:05:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@suse.cz>
cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       yi.zhu@intel.com, jketreno@linux.intel.com,
       ipw2100-devel@lists.sourceforge.net
Subject: Re: ipw2200: small cleanups
In-Reply-To: <20060831123004.GA3923@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0608311504480.16609@yvahk01.tjqt.qr>
References: <20060831123004.GA3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Remove dead, commented-out code, and switch to C-style commments.

Why can't we use C99 comments? We're already depending on so many GCC 
features that C-C99 is really nitpicky.

>-	//set the Stop and Abort bit
>+	/* set the Stop and Abort bit */

Jan Engelhardt
-- 
