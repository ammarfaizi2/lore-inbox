Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbULFQlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbULFQlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbULFQlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:41:05 -0500
Received: from peabody.ximian.com ([130.57.169.10]:30866 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261558AbULFQlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:41:03 -0500
Subject: Re: [PATCH] Time sliced CFQ #2
From: Robert Love <rml@novell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <62852042-4781-11D9-9115-000393ACC76E@mac.com>
References: <20041204104921.GC10449@suse.de>
	 <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de>
	 <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org>
	 <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org>
	 <CED75073-4743-11D9-9115-000393ACC76E@mac.com>
	 <1102310049.6052.123.camel@localhost>
	 <62852042-4781-11D9-9115-000393ACC76E@mac.com>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 11:42:18 -0500
Message-Id: <1102351338.6052.126.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The reason I proposed my ideas for tying the two values together is 
> that I am
> concerned about breaking existing code.  

Nothing should break.

If apps don't explicitly set their i/o priority, then they get the
default.  Not a big deal.

This allows the default case to be the same as today.

	Robert Love


