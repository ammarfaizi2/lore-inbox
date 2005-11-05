Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVKERoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVKERoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVKERoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:44:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32411 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750937AbVKERoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:44:17 -0500
Date: Sat, 5 Nov 2005 09:44:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI updates for 2.6.14
In-Reply-To: <1131207491.3614.5.camel@mulgrave>
Message-ID: <Pine.LNX.4.64.0511050942490.3316@g5.osdl.org>
References: <1131207491.3614.5.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Nov 2005, James Bottomley wrote:
> 
> This patch is available from:
> 
> master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git

No it's not.

	master$ git-cat-file -t HEAD

gives

	error: unable to find 39b7f1e25a412b0ef31e516cfc2fa4f40235f263
	fatal: git-cat-file HEAD: bad file

and the reason seems to be:

	master$ ll objects/39/

	ls: objects/39/: Permission denied

Hmmph.

		Linus
