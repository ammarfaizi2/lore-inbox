Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUBDBKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUBDBKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:10:52 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:56515 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265902AbUBDBKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:10:51 -0500
Date: Tue, 3 Feb 2004 17:10:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: the grugq <grugq@hcunix.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040204011040.GH2445@srv-lnx2600.matchmail.com>
Mail-Followup-To: the grugq <grugq@hcunix.net>, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <4020416B.3050301@hcunix.net> <20040204005514.GB253@elf.ucw.cz> <402043C9.8000703@hcunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402043C9.8000703@hcunix.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 12:58:49AM +0000, the grugq wrote:
> it does already zero the meta-data. I was simply asking if you think the 
> whole "erase" operation should be under the control of chattr 's', or 
> just a subset (i.e. only data overwriting is optional). Its clear now 
> that you want the whole thing to be controled by chattr 's'. I'll knock 
> that up then, and re-submit.

Yes, some people want to *keep* as much information so that it can be
undeleted (think user mistakes).
