Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268975AbUIQU1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268975AbUIQU1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268977AbUIQU1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:27:49 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:14351 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S268975AbUIQU1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:27:46 -0400
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, "Bc. Michal Semler" <cijoml@volny.cz>
Subject: Re: CD-ROM can't be ejected
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <20040917084302.GA2911@suse.de> (Jens Axboe's message of "Fri,
 17 Sep 2004 10:43:06 +0200")
References: <200409160025.35961.cijoml@volny.cz>
	<20040916070906.GK2300@suse.de> <200409160918.40767.cijoml@volny.cz>
	<20040916073616.GO2300@suse.de>
	<m3hdpx2t4d.fsf@lugabout.cloos.reno.nv.us>
	<20040917084302.GA2911@suse.de>
X-Hashcash: 0:040917:linux-kernel@vger.kernel.org:074bc69b59b8fd80
X-Hashcash: 0:040917:axboe@suse.de:bf58317903f331a3
X-Hashcash: 0:040917:cijoml@volny.cz:fd167982a45d4f90
Date: Fri, 17 Sep 2004 13:27:31 -0700
Message-ID: <m34qlwvdxo.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:

Jens> Exactly the same issue, read the thread - your tray is locked,
Jens> because someone else has the drive open.

Odd, since there is no disc in it.  lsof shows nothing; manually
looking thru /proc shows nothing.

Is there any other way to find what does?  

Is there anything internal in the kernel that might have it open
w/o reporting that fact to userspace?

-JimC
