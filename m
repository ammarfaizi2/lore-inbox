Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUIQIcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUIQIcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUIQIcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 04:32:32 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:7183 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S268515AbUIQIcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 04:32:31 -0400
To: Jens Axboe <axboe@suse.de>
Cc: "Bc. Michal Semler" <cijoml@volny.cz>, linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <20040916073616.GO2300@suse.de> (Jens Axboe's message of "Thu,
 16 Sep 2004 09:36:17 +0200")
References: <200409160025.35961.cijoml@volny.cz>
	<20040916070906.GK2300@suse.de> <200409160918.40767.cijoml@volny.cz>
	<20040916073616.GO2300@suse.de>
X-Hashcash: 0:040917:axboe@suse.de:bbd24ac55057a847
X-Hashcash: 0:040917:cijoml@volny.cz:89ea211b5418cb41
X-Hashcash: 0:040917:linux-kernel@vger.kernel.org:c58b21555adacf44
Date: Fri, 17 Sep 2004 01:32:18 -0700
Message-ID: <m3hdpx2t4d.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave this program a try as well.

Eject has been failing on my laptop for quite a few kernel
revisions.  Even using the keyboard's Fn+F10 fails.

Failures come with an extended beep -- 2 seconds or so --
and a system pause (smbios I presume).

Your eject (edited only to use /dev/hdb) reports:

:; ~/src/jens-eject 
command failed - sense 2/53/0

-JimC
