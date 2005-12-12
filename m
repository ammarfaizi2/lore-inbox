Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVLLSIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVLLSIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVLLSIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:08:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35137 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932172AbVLLSIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:08:36 -0500
Date: Mon, 12 Dec 2005 19:09:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Brian King <brking@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Memory corruption & SCSI in 2.6.15
Message-ID: <20051212180952.GA12024@suse.de>
References: <1134371606.6989.95.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134371606.6989.95.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12 2005, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Current -git as of today (that is 2.6.15-rc5 + the batch of fixes Linus
> pulled after his return) was dying in weird ways for me on POWER5. I had
> the good idea to activate slab debugging, and I now see it detecting
> slab corruption as soon as the IPR driver initializes.
> 
> Since I remember seeing a discussion somewhere on a list between Brian
> King and Jens Axboe about use-after-free problems in SCSI and possible
> other niceties of that sort, I though it might be related...

When did this start happening (roughly)?

-- 
Jens Axboe

